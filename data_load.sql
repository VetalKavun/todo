insert into team (`title`, `description`) values ("DEV", "DEV_title");
insert into team (`title`, `description`) values ("QA", "QA_title");
insert into team (`title`, `description`) values ("PM", "PM_title");

select * from team;

insert into role(`role`) values ('USER');
insert into role(`role`) values ('ADMIN');
insert into role(`role`) values ('MANAGER');

select * from role;


insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_1", "useremail_1", "userpassword_1", 1,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_2", "useremail_2", "userpassword_2", 2,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_3", "useremail_3", "userpassword_3", 1,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_4", "useremail_4", "userpassword_4", 2,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_5", "useremail_5", "userpassword_5", 2,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_6", "useremail_6", "userpassword_6", 1,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_7", "useremail_7", "userpassword_7", 3,  2);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_8", "useremail_8", "userpassword_8", 2,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_9", "useremail_9", "userpassword_9", 1,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_10", "useremail_10", "userpassword_10", 2,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_11", "useremail_11", "userpassword_11", 1,  1);
insert into user (`user_name`, `email`, `password`, `team_id`, `user_role`) values ("username_12", "useremail_12", "userpassword_12", 1,  1);

select * from user;

insert into project (`title`, `description`, `time_spent`) values ("project_title_1", "project_description_1", null);
insert into project (`title`, `description`, `time_spent`) values ("project_title_2", "project_description_2", null);
insert into project (`title`, `description`, `time_spent`) values ("project_title_3", "project_description_3", null);
insert into project (`title`, `description`, `time_spent`) values ("project_title_4", "project_description_4", null);

select * from project;

insert into task (`description`, `title`, `user_creator_id`, `estimate`, `spent_time`, `start_time`, `finish_time`, `user_reviewer_id`, `status`, `last_update`, `project_project_id`) 
	values ("task_description_1", "task_title_1", 2, "4", null, null, null, 2, "active", CURRENT_TIMESTAMP(), 1);
insert into task (`description`, `title`, `user_creator_id`, `estimate`, `spent_time`, `start_time`, `finish_time`, `user_reviewer_id`, `status`, `last_update`, `project_project_id`) 
	values ("task_description_2", "task_title_2", 2, "4", null, null, null, 2, "active", CURRENT_TIMESTAMP(), 2);
insert into task (`description`, `title`, `user_creator_id`, `estimate`, `spent_time`, `start_time`, `finish_time`, `user_reviewer_id`, `status`, `last_update`, `project_project_id`) 
	values ("task_description_3", "task_title_3", 3, "4", null, null, null, 2, "active", CURRENT_TIMESTAMP(), 3);
insert into task (`description`, `title`, `user_creator_id`, `estimate`, `spent_time`, `start_time`, `finish_time`, `user_reviewer_id`, `status`, `last_update`, `project_project_id`) 
	values ("task_description_4", "task_title_4", 3, "4", null, null, null, 2, "active", CURRENT_TIMESTAMP(), 1);
    
select * from task;
    
insert into user_task values (2, 4);
insert into user_task values (5, 3);
insert into user_task values (2, 3);
insert into user_task values (3, 5);
insert into user_task values (3, 3);
insert into user_task values (4, 2);
insert into user_task values (4, 3);
insert into user_task values (5, 2);

select * from user_task;   

insert into user_project values (2, 2);
insert into user_project values (2, 3);
insert into user_project values (3, 1);
insert into user_project values (3, 3);
insert into user_project values (4, 3);
insert into user_project values (4, 2);
insert into user_project values (4, 4);
insert into user_project values (3, 2); 
    