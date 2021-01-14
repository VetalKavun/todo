-- -----------------------------------------------------
-- Schema task_manager
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `task_manager` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `task_manager` ;

-- -----------------------------------------------------
-- Table `task_manager`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`team` (
  `team_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`team_id`),
  UNIQUE INDEX `team_id_UNIQUE` (`team_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_manager`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `team_id` INT NOT NULL,
  `user_role` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC) VISIBLE,
  INDEX `fk_user_team_idx` (`team_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_team`
    FOREIGN KEY (`team_id`)
    REFERENCES `task_manager`.`team` (`team_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role`
    FOREIGN KEY (`user_role`)
    REFERENCES `task_manager`.`role` (`role_id`)
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_manager`.`project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`project` (
  `project_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(255) NOT NULL,
  `description` MEDIUMTEXT NULL,
  `time_spent` TIMESTAMP NULL,
  PRIMARY KEY (`project_id`),
  UNIQUE INDEX `project_id_UNIQUE` (`project_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_manager`.`task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`task` (
  `task_id` INT NOT NULL AUTO_INCREMENT,
  `description` MEDIUMTEXT NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `user_creator_id` INT NOT NULL,
  `estimate` VARCHAR(45) NOT NULL,
  `spent_time` TIMESTAMP NULL,
  `start_time` TIMESTAMP NULL,
  `finish_time` TIMESTAMP NULL,
  `user_reviewer_id` INT NULL,
  `status` VARCHAR(45) NOT NULL,
  `last_update` TIMESTAMP NOT NULL,
  `project_project_id` INT NOT NULL,
  PRIMARY KEY (`task_id`),
  INDEX `fk_task_project1_idx` (`project_project_id` ASC) VISIBLE,
  CONSTRAINT `fk_task_project1`
    FOREIGN KEY (`project_project_id`)
    REFERENCES `task_manager`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_user1`
    FOREIGN KEY (`user_creator_id`)
    REFERENCES `task_manager`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_task_user2`
    FOREIGN KEY (`user_reviewer_id`)
    REFERENCES `task_manager`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `task_manager`.`users_task`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `task_manager`.`user_task` (
  `user_id` INT NOT NULL,
  `task_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `task_id`),
  INDEX `fk_user_has_task_task1_idx` (`task_id` ASC) VISIBLE,
  INDEX `fk_user_has_task_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_users_has_task_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `task_manager`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_task_task1`
    FOREIGN KEY (`task_id`)
    REFERENCES `task_manager`.`task` (`task_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NO EXISTS `task_manager`.`user_project` (
  `user_id` INT NOT NULL,
  `project_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `project_id`),
  INDEX `fk_user_has_project_user1_idx` (`user_id`, ASC) VISIBLE,
  INDEX `fk_user_has_project_project1_idx` (`project_id`, ASC) VISIBLE,
  CONSTRAINT `fk_user_has_project_user1_idx`
    FOREIGN KEY (`user_id`)
    REFERENCES `task_manager`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_project_project1_idx`
    FOREIGN KEY (`project_id`)
    REFERENCES `task_manager`.`project` (`project_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS `task_manager`.`role` (
  `role_id` INT NOT NULL AUTO_INCREMENT,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`role_id`),
  UNIQUE INDEX `role_id_UNIQUE` (`role_id`, ASC) VISIBLE
)ENGINE = InnoDB;