SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fardb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fardb` DEFAULT CHARACTER SET utf8 ;
USE `fardb` ;

-- -----------------------------------------------------
-- Table `fardb`.`admin`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`admin` ;

CREATE TABLE IF NOT EXISTS `fardb`.`admin` (
  `admin_id` INT(11) NOT NULL,
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `mobile` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`admin_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `fardb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`user` ;

CREATE TABLE IF NOT EXISTS `fardb`.`user` (
  `user_id` INT(11) NOT NULL,
  `verified` TINYINT(1) NOT NULL DEFAULT '0',
  `username` VARCHAR(20) NOT NULL,
  `password` VARCHAR(60) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `middle_name` VARCHAR(50) NULL DEFAULT NULL,
  `name` VARCHAR(50) NOT NULL,
  `surname` VARCHAR(50) NOT NULL,
  `telephone` VARCHAR(32) NULL DEFAULT NULL,
  `telephone_2` VARCHAR(32) NULL DEFAULT NULL,
  `fax` VARCHAR(32) NULL DEFAULT NULL,
  `lessor` TINYINT(1) NOT NULL,
  `seller` TINYINT(1) NOT NULL,
  `lessee` TINYINT(1) NOT NULL,
  `buyer` TINYINT(1) NOT NULL,
  `profile_picture` VARCHAR(128) NULL DEFAULT NULL,
  `join_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `register_ip` INT(11) NOT NULL,
  `address_1` VARCHAR(64) NOT NULL,
  `address_2` VARCHAR(64) NULL,
  `address_3` VARCHAR(64) NULL,
  `city` VARCHAR(64) NOT NULL,
  `region` VARCHAR(64) NOT NULL,
  `postal_code` VARCHAR(8) NOT NULL,
  `country` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fardb`.`property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`property` ;

CREATE TABLE IF NOT EXISTS `fardb`.`property` (
  `property_id` INT(11) NOT NULL,
  `owner_user_id` INT(11) NOT NULL,
  `date_added` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `for_sale` TINYINT(1) NOT NULL,
  `for_rent` TINYINT(1) NOT NULL,
  `isApartment` TINYINT(1) NOT NULL,
  `isHouse` TINYINT(1) NOT NULL,
  `build_date` INT(11) NOT NULL,
  `renovation_date` INT(11) NULL DEFAULT NULL,
  `price` DECIMAL(19,4) NOT NULL,
  `maintenance_charges` DECIMAL(19,4) NOT NULL,
  `sq_meters` FLOAT NOT NULL,
  `rooms_no` INT(11) NOT NULL,
  `ap_floor` INT(11) NULL DEFAULT NULL,
  `h_floors` INT(11) NULL DEFAULT NULL,
  `heating_system` VARCHAR(20) NOT NULL,
  `air_conditioner` TINYINT(1) NOT NULL,
  `parking` TINYINT(1) NOT NULL,
  `elevator` TINYINT(1) NOT NULL,
  `views` INT(11) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `address_1` VARCHAR(64) NOT NULL,
  `address_2` VARCHAR(64) NULL,
  `address_3` VARCHAR(64) NULL,
  `city` VARCHAR(64) NOT NULL,
  `region` VARCHAR(64) NOT NULL,
  `postal_code` VARCHAR(8) NOT NULL,
  `country` VARCHAR(32) NOT NULL,
  `latitude` DECIMAL(9,4) NOT NULL,
  `longitude` DECIMAL(9,4) NOT NULL,
  PRIMARY KEY (`property_id`, `owner_user_id`),
  INDEX `fk_property_user1_idx` (`owner_user_id` ASC),
  CONSTRAINT `fk_property_user1`
    FOREIGN KEY (`owner_user_id`)
    REFERENCES `fardb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `fardb`.`messages`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`messages` ;

CREATE TABLE IF NOT EXISTS `fardb`.`messages` (
  `message_id` INT(11) NOT NULL,
  `owner_user_id` INT(11) NOT NULL,
  `property_id` INT(11) NOT NULL,
  `from_user_id` INT(11) NOT NULL,
  `message` TEXT NOT NULL,
  PRIMARY KEY (`message_id`, `owner_user_id`, `property_id`),
  INDEX `fk_messages_user1_idx` (`from_user_id` ASC),
  INDEX `fk_messages_property1_idx` (`property_id` ASC, `owner_user_id` ASC),
  CONSTRAINT `fk_messages_property1`
    FOREIGN KEY (`property_id` , `owner_user_id`)
    REFERENCES `fardb`.`property` (`property_id` , `owner_user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_messages_user1`
    FOREIGN KEY (`from_user_id`)
    REFERENCES `fardb`.`user` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fardb`.`property_photos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`property_photos` ;

CREATE TABLE IF NOT EXISTS `fardb`.`property_photos` (
  `photo_id` INT(11) NOT NULL,
  `property_property_id` INT(11) NOT NULL,
  `property_owner_user_id` INT(11) NOT NULL,
  `path` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`photo_id`, `property_property_id`, `property_owner_user_id`),
  INDEX `fk_property_photos_property1_idx` (`property_property_id` ASC, `property_owner_user_id` ASC),
  CONSTRAINT `fk_property_photos_property1`
    FOREIGN KEY (`property_property_id` , `property_owner_user_id`)
    REFERENCES `fardb`.`property` (`property_id` , `owner_user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fardb`.`algorithm`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`algorithm` ;

CREATE TABLE IF NOT EXISTS `fardb`.`algorithm` (
  `name` VARCHAR(7) NOT NULL,
  `running` TINYINT(1) NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fardb`.`ids`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fardb`.`ids` ;

CREATE TABLE IF NOT EXISTS `fardb`.`ids` (
  `name` VARCHAR(20) NOT NULL,
  `id_num` INT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `fardb`.`admin` (`admin_id`, `username`, `password`, `email`, `mobile`)
VALUES ('1', 'admin', '$2a$10$9mZ2KwYdsBFi6T.HNiJz/O9y7rUvv4eudSOBvHd0HhJ1F2iYMTzK2', 'admin@hotmail.com', NULL);

INSERT INTO `fardb`.`ids` (`name`, `id_num`)
VALUES('message_id', '1');

INSERT INTO `fardb`.`ids` (`name`, `id_num`)
VALUES('photo_id', '1');

INSERT INTO `fardb`.`ids` (`name`, `id_num`)
VALUES('property_id', '1');

INSERT INTO `fardb`.`ids` (`name`, `id_num`)
VALUES('user_id', '1');

INSERT INTO `fardb`.`algorithm`(`name`, `running`)
VALUES('saw', '1');

INSERT INTO `fardb`.`algorithm`(`name`, `running`)
VALUES('topsis', '0');