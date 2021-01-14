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