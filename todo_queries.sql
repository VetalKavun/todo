select project.title as pr_title, project.description as pr_description, task.title as task_title from task 
inner join project on task.project_project_id = project.project_id
where project.project_id = 1;

select u.user_name, t.title from user u 
inner join user_task ut on u.user_id = ut.user_id 
inner join task t on ut.task_id = t.task_id 
where u.user_id = 2;

select p.title as pr_title, team.title as team_title from team
inner join user u on u.team_id = team.team_id
inner join user_task ut on u.user_id = ut.user_id 
inner join task t on ut.task_id = t.task_id 
inner join project p on t.project_project_id = p.project_id
where p.project_id = 2;
-- group by team_title;

select u.user_name, t.title from user u 
inner join team t on t.team_id = u.team_id
order by u.user_name;

select p.title, u.user_name  from user u 
inner join user_task ut on ut.user_id = u.user_id
inner join task on ut.task_id = task.task_id
inner join project p on p.project_id = task.project_project_id
where p.project_id = 2;


select p.title as pr_title, sec_to_time(sum(time_to_sec(spent_time))) as spent_time from task t 
inner join project p on t.project_project_id = p.project_id
where p.project_id = 1;

select t.title as task_title, t.spent_time from task t


select p.time_spent as spent_time from project p;

select p.title as pr_title, team.title as team_title from team
inner join user u on u.team_id = team.team_id
inner join user_task ut on u.user_id = ut.user_id 
inner join task t on ut.task_id = t.task_id 
inner join project p on t.project_project_id = p.project_id
where p.project_id = 2;

select count(u.user_name) from user u 
inner join team on team.team_id = u.team_id
inner join user_task ut on u.user_id = ut.user_id
inner join task on task.task_id = ut.task_id
inner join project p on p.project_id = task.project_project_id
where p.project_id = 2
AND team.title = 'DEV';
-- and where u.team_id = 'DEV';


DELIMITER $$

create trigger task_after_update
after update
on task for each row
begin
if old.spent_time <> new.spent_time then
	update project set time_spent = addtime(time_spent, new.spent_time);
end if;

end $$

DELIMITER ;

drop trigger if exists task_manager.task_after_update;