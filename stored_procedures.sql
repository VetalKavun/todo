DELIMITER $$ 
CREATE PROCEDURE change_task_status(
	IN task_id_in INT,
	IN status_in VARCHAR(45),
	IN user_id_in INT,
	OUT email_out VARCHAR(255),
	OUT message_out VARCHAR(500)
)
BEGIN
	DECLARE old_status VARCHAR(45) DEFAULT "";
	DECLARE task_title VARCHAR(255) DEFAULT "";
	DECLARE username VARCHAR(255) DEFAULT "";
    DECLARE start_time TIMESTAMP;

	SELECT u.email INTO email_out from user u 
	INNER JOIN task t on t.user_creator_id = u.user_id
	WHERE task_id = task_id_in; 

	SELECT status INTO old_status FROM task WHERE task_id = task_id_in;
	SELECT user.user_name INTO username FROM user WHERE user.user_id = user_id_in;

	IF old_status = "active" AND status_in = "in progress" THEN
		UPDATE task SET task.status = status_in, task.start_time = CURRENT_TIMESTAMP() WHERE task.task_id = task_id_in;
	END IF;
    
    IF old_status = "in progress" AND status_in = "done" THEN
		UPDATE task SET task.status = status_in, task.finish_time = CURRENT_TIMESTAMP() WHERE task.task_id = task_id_in;
	END IF;
    
    IF status_in = "on hold" THEN
		UPDATE task SET task.status = status_in, task.start_time = CURRENT_TIMESTAMP() WHERE task.task_id = task_id_in;
	END IF;
    
    SET message_out = CONCAT("Hello! ", username, " had changed the status of task ", task_title, " from ", old_status, " to ", status_in, " at ", CURRENT_TIMESTAMP());
    
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE create_task_for_user(
	IN description_in MEDIUMTEXT,
    IN user_id_in INT,
    IN title_in VARCHAR(255),
    IN user_creator_id_in INT,
    IN estimate_in TIMESTAMP,
    IN user_reviewer_id_in INT,
    IN project_id_in INT,
    OUT user_email_out VARCHAR(255),
    OUT message_out VARCHAR(255)
)
BEGIN 

	DECLARE task_id INT;
    DECLARE user_name VARCHAR(255);
    
    SELECT u.email, u.user_name INTO user_email_out, user_name  from user u WHERE user_id = user_id_in;

	INSERT INTO task (`description`, `title`, `user_creator_id`, `estimate`, `spent_time`, `start_time`, `finish_time`, `user_reviewer_id`, `status`, `last_update`, `project_project_id`)
    VALUES (description_in, title_in, user_creator_id_in, estimate_in, null, CURRENT_TIMESTAMP(), null, user_reviewer_id_in, 'ACTIVE', CURRENT_TIMESTAMP(), project_id_in);
    SELECT LAST_INSERT_ID() INTO task_id;
    INSERT INTO user_task  VALUES (user_id_in, task_id);
	SET message_out = CONCAT("Hello, ", user_name, ", task ", title_in, " was assigned to you at ", CURRENT_TIMESTAMP);
END $$
DELIMITER ;



DELIMITER $$
CREATE PROCEDURE close_task(
	IN task_id_in INT,
    OUT message_out VARCHAR(45)
)
BEGIN 
	UPDATE task SET finish_time = CURRENT_TIMESTAMP(), status = 'Closed', last_update = CURRENT_TIMESTAMP();
    INSERT INTO story (`user_id`, `task_id`) SELECT ut.user_id, ut.task_id FROM user_task ut WHERE ut.task_id = task_id_in;
	DELETE FROM user_task WHERE task_id = task_id_in;
    SET message_out = 'task was closed';
END $$
DELIMITER ;

DELIMITER $$ 
CREATE PROCEDURE reopen_task(
	IN task_id_in INT,
    IN user_id_in INT,
    OUT message_out VARCHAR(255)
)
BEGIN
	DECLARE user_name VARCHAR(255);
    DECLARE task_title VARCHAR(255);
    
    SELECT title INTO task_title FROM task WHERE task_id = task_id_in;
    SELECT user.user_name INTO user_name FROM user WHERE user_id = user_id_in;
	UPDATE task set status = 'Active', start_time = CURRENT_TIMESTAMP(), last_update = CURRENT_TIMESTAMP() WHERE task_id = task_id_in;
    INSERT INTO user_task VALUES (user_id_in, task_id_in);
    DELETE FROM story WHERE task_id = task_id_in AND user_id = user_id_in;
    SET message_out = CONCAT("Hello, ", user_name, ", task ", task_title, " was reopend and assigned to you at ", CURRENT_TIMESTAMP());
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE get_free_users(
	IN project_id_in INT,
    IN team_id_in VARCHAR (255)
)
BEGIN
	IF team_id_in is not null THEN
		select u.user_name, t.title from user u
		inner join team t on u.team_id = t.team_id
		inner join user_project up on u.user_id = up.user_id
		inner join project p on p.project_id = up.project_id
		where p.project_id = 2 
		AND u.user_id not in(select distinct user_id from user_task)
		AND t.team_id = team_id_in; 
	ELSE
		select u.user_name, t.title from user u
		inner join team t on u.team_id = t.team_id
		inner join user_project up on u.user_id = up.user_id
		inner join project p on p.project_id = up.project_id
		where p.project_id = 2 AND u.user_id not in(select distinct user_id from user_task); 
	END IF;	
END $$
DELIMITER ;
