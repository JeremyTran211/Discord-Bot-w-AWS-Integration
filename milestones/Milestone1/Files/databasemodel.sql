-- MySQL Script generated by MySQL Workbench
-- Fri Jul 14 22:48:28 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Name the database
-- DATABASE WasteManagementDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `User`
-- -----------------------------------------------------
-- DO NOT FORGET THE DROP DATABASE STATEMENT 

DROP DATABASE IF EXISTS "WasteManagementDB";
CREATE DATABASE IF NOT EXISTS "WasteManagementDB";
USE "WasteManagementDB";

DROP TABLE IF EXISTS `User` ;

CREATE TABLE IF NOT EXISTS `User` (
  `user_ID` INT NOT NULL,
  `user_location` VARCHAR(60) NULL,
  `user_email` VARCHAR(45) NULL,
  PRIMARY KEY (`user_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Account` ;

CREATE TABLE IF NOT EXISTS `Account` (
  `account_ID` INT NOT NULL,
  `user_ID` INT NOT NULL,
  `user_Name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`account_ID`, `user_ID`, `user_Name`),
  INDEX `user_ID_idx` (`user_ID` ASC) VISIBLE,
  CONSTRAINT `FKPKuser_ID`
    FOREIGN KEY (`user_ID`)
    REFERENCES `User` (`user_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Service_Providers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Service_Providers` ;

CREATE TABLE IF NOT EXISTS `Service_Providers` (
  `service_ID` INT NOT NULL,
  `service_type` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NULL,
  `serv` VARCHAR(45) NULL,
  PRIMARY KEY (`service_ID`, `service_type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Collection_Schedule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Collection_Schedule` ;

CREATE TABLE IF NOT EXISTS `Collection_Schedule` (
  `Collection_Schedule_ID` INT NOT NULL,
  `schedule_Title` VARCHAR(45) NOT NULL,
  `schedule_description` VARCHAR(45) NULL,
  `account_ID` INT NOT NULL,
  `service_ID` INT NULL,
  PRIMARY KEY (`Collection_Schedule_ID`, `account_ID`),
  INDEX `account_ID_idx` (`account_ID` ASC) VISIBLE,
  INDEX `service_ID_idx` (`service_ID` ASC) VISIBLE,
  CONSTRAINT `account_ID`
    FOREIGN KEY (`account_ID`)
    REFERENCES `Account` (`account_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `service_ID`
    FOREIGN KEY (`service_ID`)
    REFERENCES `Service_Providers` (`service_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Treatment_Technology`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Treatment_Technology` ;

CREATE TABLE IF NOT EXISTS `Treatment_Technology` (
  `tech_Name` VARCHAR(45) NOT NULL,
  `tech_Manufacturer` VARCHAR(45) NULL,
  `tech_description` VARCHAR(150) NULL,
  PRIMARY KEY (`tech_Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Treatment_Process`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Treatment_Process` ;

CREATE TABLE IF NOT EXISTS `Treatment_Process` (
  `process_Name` VARCHAR(45) NOT NULL,
  `process_Description` VARCHAR(150) NULL,
  `tech_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`process_Name`),
  CONSTRAINT `tech_Name`
    FOREIGN KEY ()
    REFERENCES `Treatment_Technology` ()
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Vechicle_Fleet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Vechicle_Fleet` ;

CREATE TABLE IF NOT EXISTS `Vechicle_Fleet` (
  `vehicle_Type` VARCHAR(45) NOT NULL,
  `vehicle_Capacity` VARCHAR(45) NULL,
  `vehicle_description` VARCHAR(150) NULL,
  PRIMARY KEY (`vehicle_Type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Recycling_Center`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Recycling_Center` ;

CREATE TABLE IF NOT EXISTS `Recycling_Center` (
  `center_ID` INT NOT NULL,
  `center_Name` VARCHAR(45) NOT NULL,
  `center_Infomation` VARCHAR(100) NULL,
  `center_Location` VARCHAR(45) NULL,
  `service_Type` VARCHAR(45) NULL,
  `process_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`center_ID`),
  INDEX `service_Type_idx` (`service_Type` ASC) VISIBLE,
  INDEX `process_Name_idx` (`process_Name` ASC) VISIBLE,
  CONSTRAINT `service_Type`
    FOREIGN KEY (`service_Type`)
    REFERENCES `Service_Providers` (`service_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `process_Name`
    FOREIGN KEY (`process_Name`)
    REFERENCES `Treatment_Process` (`process_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `vehicle_Type`
    FOREIGN KEY (`process_Name`)
    REFERENCES `Vechicle_Fleet` (`vehicle_Type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Treatment_Facility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Treatment_Facility` ;

CREATE TABLE IF NOT EXISTS `Treatment_Facility` (
  `facility_ID` INT NOT NULL,
  `facility_Name` VARCHAR(45) NULL,
  `facility_Infomation` VARCHAR(150) NULL,
  `service_Type` VARCHAR(45) NULL,
  `process_Name` VARCHAR(45) NULL,
  `vehicle_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`facility_ID`),
  INDEX `service_Type_idx` (`service_Type` ASC) VISIBLE,
  INDEX `process_Name_idx` (`process_Name` ASC) VISIBLE,
  INDEX `vehicle_Type_idx` (`vehicle_Type` ASC) VISIBLE,
  CONSTRAINT `service_Type`
    FOREIGN KEY (`service_Type`)
    REFERENCES `Service_Providers` (`service_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `process_Name`
    FOREIGN KEY (`process_Name`)
    REFERENCES `Treatment_Process` (`process_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `vehicle_Type`
    FOREIGN KEY (`vehicle_Type`)
    REFERENCES `Vechicle_Fleet` (`vehicle_Type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Transporter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Transporter` ;

CREATE TABLE IF NOT EXISTS `Waste_Transporter` (
  `transporter_ID` INT NOT NULL,
  `transporter_Name` VARCHAR(45) NOT NULL,
  `transporter_Infomation` VARCHAR(150) NULL,
  `service_Type` VARCHAR(45) NULL,
  `process_Name` VARCHAR(45) NULL,
  `vehicle_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`transporter_ID`),
  INDEX `service_Type_idx` (`service_Type` ASC) VISIBLE,
  INDEX `process_Name_idx` (`process_Name` ASC) VISIBLE,
  INDEX `vehicle_Type_idx` (`vehicle_Type` ASC) VISIBLE,
  CONSTRAINT `service_Type`
    FOREIGN KEY (`service_Type`)
    REFERENCES `Service_Providers` (`service_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `process_Name`
    FOREIGN KEY (`process_Name`)
    REFERENCES `Treatment_Process` (`process_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `vehicle_Type`
    FOREIGN KEY (`vehicle_Type`)
    REFERENCES `Vechicle_Fleet` (`vehicle_Type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Disposal_Site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Disposal_Site` ;

CREATE TABLE IF NOT EXISTS `Waste_Disposal_Site` (
  `site_ID` INT NOT NULL,
  `site_Name` VARCHAR(45) NULL,
  `site_Infomation` VARCHAR(150) NULL,
  `site_Capacity` VARCHAR(20) NULL,
  `service_Type` VARCHAR(45) NULL,
  `process_Name` VARCHAR(45) NULL,
  `vehicle_Type` VARCHAR(45) NULL,
  PRIMARY KEY (`site_ID`),
  INDEX `service_Type_idx` (`service_Type` ASC) VISIBLE,
  INDEX `process_Name_idx` (`process_Name` ASC) VISIBLE,
  INDEX `vehicle_Type_idx` (`vehicle_Type` ASC) VISIBLE,
  CONSTRAINT `service_Type`
    FOREIGN KEY (`service_Type`)
    REFERENCES `Service_Providers` (`service_type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `process_Name`
    FOREIGN KEY (`process_Name`)
    REFERENCES `Treatment_Process` (`process_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `vehicle_Type`
    FOREIGN KEY (`vehicle_Type`)
    REFERENCES `Vechicle_Fleet` (`vehicle_Type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Generator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Generator` ;

CREATE TABLE IF NOT EXISTS `Waste_Generator` (
  `generator_Type` CHAR(15) NOT NULL,
  `generator_Location` VARCHAR(45) NULL,
  `generator_Description` VARCHAR(150) NULL,
  PRIMARY KEY (`generator_Type`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Item` ;

CREATE TABLE IF NOT EXISTS `Waste_Item` (
  `item_Name` VARCHAR(45) NOT NULL,
  `item_Description` CHAR(100) NULL,
  `item_Quantity` VARCHAR(45) NULL,
  `generator_Type` CHAR(15) NULL,
  PRIMARY KEY (`item_Name`),
  INDEX `generator_Type_idx` (`generator_Type` ASC) VISIBLE,
  CONSTRAINT `generator_Type`
    FOREIGN KEY (`generator_Type`)
    REFERENCES `Waste_Generator` (`generator_Type`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Category` ;

CREATE TABLE IF NOT EXISTS `Waste_Category` (
  `category_Name` VARCHAR(45) NOT NULL,
  `category_Description` VARCHAR(100) NULL,
  `Waste_Categorycol` VARCHAR(45) NULL,
  `item_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`category_Name`),
  INDEX `item_Name_idx` (`item_Name` ASC) VISIBLE,
  CONSTRAINT `item_Name`
    FOREIGN KEY (`item_Name`)
    REFERENCES `Waste_Item` (`item_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Regulatory_Body`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Regulatory_Body` ;

CREATE TABLE IF NOT EXISTS `Regulatory_Body` (
  `body_ID` INT NOT NULL,
  `body_Name` VARCHAR(45) NULL,
  `body_Website` VARCHAR(100) NULL,
  `Parent_body_ID` INT NULL,
  PRIMARY KEY (`body_ID`),
  INDEX `parent_body_ID_idx` (`Parent_body_ID` ASC) VISIBLE,
  CONSTRAINT `FKparent_body_ID`
    FOREIGN KEY (`Parent_body_ID`)
    REFERENCES `Regulatory_Body` (`body_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Regulation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Regulation` ;

CREATE TABLE IF NOT EXISTS `Regulation` (
  `regulations_ID` INT NOT NULL,
  `regulation_Title` VARCHAR(45) NULL,
  `regulation_Description` VARCHAR(200) NULL,
  `body_ID` INT NOT NULL,
  PRIMARY KEY (`regulations_ID`),
  INDEX `body_ID_idx` (`body_ID` ASC) VISIBLE,
  CONSTRAINT `body_ID`
    FOREIGN KEY (`body_ID`)
    REFERENCES `Regulatory_Body` (`body_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Health_and_Safety_Records`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Health_and_Safety_Records` ;

CREATE TABLE IF NOT EXISTS `Health_and_Safety_Records` (
  `HSrecord_ID` INT NOT NULL,
  `HSrecord_violation_type` VARCHAR(45) NULL,
  `HSrecord_resolution_status` VARCHAR(45) NULL,
  PRIMARY KEY (`HSrecord_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Sustainability_Initatives`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Sustainability_Initatives` ;

CREATE TABLE IF NOT EXISTS `Sustainability_Initatives` (
  `init_ID` INT NOT NULL,
  `init_Name` VARCHAR(45) NULL,
  `init_description` VARCHAR(200) NULL,
  PRIMARY KEY (`init_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Educational_Programs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Educational_Programs` ;

CREATE TABLE IF NOT EXISTS `Educational_Programs` (
  `program_ID` INT NOT NULL,
  `program_Name` VARCHAR(45) NOT NULL,
  `program_Description` VARCHAR(45) NULL,
  PRIMARY KEY (`program_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Full _Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Full _Access` ;

CREATE TABLE IF NOT EXISTS `Full _Access` (
  `Access_ID` INT NOT NULL,
  `access_Granted_Date` DATETIME NULL,
  `Full Accesscol` VARCHAR(45) NULL,
  `account_ID` INT NULL,
  `HSrecord_ID` INT NOT NULL,
  `Init_ID` INT NULL,
  `program_ID` INT NULL,
  `body_ID` INT NULL,
  INDEX `FKaccount_ID_idx` (`account_ID` ASC) VISIBLE,
  PRIMARY KEY (`Access_ID`),
  INDEX `HS_record_ID_idx` (`HSrecord_ID` ASC) VISIBLE,
  INDEX `init_ID` () VISIBLE,
  INDEX `init_ID_idx` (`Init_ID` ASC) VISIBLE,
  INDEX `program_ID_idx` (`program_ID` ASC) VISIBLE,
  INDEX `body_ID_idx` (`body_ID` ASC) VISIBLE,
  CONSTRAINT `FKaccount_ID`
    FOREIGN KEY (`account_ID`)
    REFERENCES `Account` (`account_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `HS_record_ID`
    FOREIGN KEY (`HSrecord_ID`)
    REFERENCES `Health_and_Safety_Records` (`HSrecord_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `init_ID`
    FOREIGN KEY (`Init_ID`)
    REFERENCES `Sustainability_Initatives` (`init_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `program_ID`
    FOREIGN KEY (`program_ID`)
    REFERENCES `Educational_Programs` (`program_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `body_ID`
    FOREIGN KEY (`body_ID`)
    REFERENCES `Regulatory_Body` (`body_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Track`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Track` ;

CREATE TABLE IF NOT EXISTS `Waste_Track` (
  `track_ID` INT NOT NULL,
  `access_ID` INT NULL,
  `category_Name` VARCHAR(45) NULL,
  PRIMARY KEY (`track_ID`),
  INDEX `access_ID_idx` (`access_ID` ASC) VISIBLE,
  INDEX `category_ID_idx` (`category_Name` ASC) VISIBLE,
  CONSTRAINT `access_ID`
    FOREIGN KEY (`access_ID`)
    REFERENCES `Full _Access` (`Access_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `category_Name`
    FOREIGN KEY (`category_Name`)
    REFERENCES `Waste_Category` (`category_Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Report`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Report` ;

CREATE TABLE IF NOT EXISTS `Waste_Report` (
  `report_ID` INT NOT NULL,
  `report_Title` VARCHAR(45) NULL,
  `report_Description` VARCHAR(150) NULL,
  `account_ID` INT NOT NULL,
  `Waste_Reportcol` VARCHAR(45) NULL,
  `regulation_ID` INT NULL,
  `track_ID` INT NULL,
  PRIMARY KEY (`report_ID`, `account_ID`),
  INDEX `account_ID_idx` (`account_ID` ASC) VISIBLE,
  INDEX `regulation_ID_idx` (`regulation_ID` ASC) VISIBLE,
  INDEX `track_ID_idx` (`track_ID` ASC) VISIBLE,
  CONSTRAINT `FKPKaccount_ID`
    FOREIGN KEY (`account_ID`)
    REFERENCES `Account` (`account_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `regulation_ID`
    FOREIGN KEY (`regulation_ID`)
    REFERENCES `Regulation` (`regulations_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `track_ID`
    FOREIGN KEY (`track_ID`)
    REFERENCES `Waste_Track` (`track_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Environmental_Impact_Data`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Environmental_Impact_Data` ;

CREATE TABLE IF NOT EXISTS `Environmental_Impact_Data` (
  `data_ID` INT NOT NULL,
  `data_Collection_date` DATETIME NULL,
  `data_Description` VARCHAR(150) NULL,
  PRIMARY KEY (`data_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Waste_Logs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Waste_Logs` ;

CREATE TABLE IF NOT EXISTS `Waste_Logs` (
  `log_ID` INT NOT NULL,
  `log_Description` VARCHAR(150) NULL,
  `log_Timestamp` TIME NULL,
  `regulation_ID` INT NOT NULL,
  `impact_ID` INT NULL,
  `track_ID` INT NULL,
  PRIMARY KEY (`log_ID`, `regulation_ID`),
  INDEX `regulation_ID_idx` (`regulation_ID` ASC) VISIBLE,
  INDEX `impact_ID_idx` (`impact_ID` ASC) VISIBLE,
  CONSTRAINT `regulation_ID`
    FOREIGN KEY (`regulation_ID`)
    REFERENCES `Regulation` (`regulations_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `impact_ID`
    FOREIGN KEY (`impact_ID`)
    REFERENCES `Environmental_Impact_Data` (`data_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `track_ID`
    FOREIGN KEY ()
    REFERENCES `Waste_Track` ()
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inventory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inventory` ;

CREATE TABLE IF NOT EXISTS `Inventory` (
  `inventory_ID` INT NOT NULL,
  `inventory_Use_Type` CHAR(50) NULL,
  `inventory_Quantity` VARCHAR(45) NULL,
  `generator_ID` INT NULL,
  `service_ID` INT NULL,
  PRIMARY KEY (`inventory_ID`),
  INDEX `service_ID_idx` (`service_ID` ASC) VISIBLE,
  CONSTRAINT `service_ID`
    FOREIGN KEY (`service_ID`)
    REFERENCES `Service_Providers` (`service_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Read_Access`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Read_Access` ;

CREATE TABLE IF NOT EXISTS `Read_Access` (
  `read_ID` INT NOT NULL,
  `read_granted` DATETIME NULL,
  `account_ID` INT NOT NULL,
  `log_ID` INT NOT NULL,
  PRIMARY KEY (`read_ID`),
  INDEX `FKaccount_ID_idx` (`account_ID` ASC) VISIBLE,
  INDEX `FKlog_ID_idx` (`log_ID` ASC) VISIBLE,
  CONSTRAINT `FKaccount_ID`
    FOREIGN KEY (`account_ID`)
    REFERENCES `Account` (`account_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FKlog_ID`
    FOREIGN KEY (`log_ID`)
    REFERENCES `Waste_Logs` (`log_ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Records`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Records` ;

CREATE TABLE IF NOT EXISTS `Records` (
  `record_ID` INT NOT NULL,
  `record_Type` VARCHAR(45) NULL,
  `record_Date` DATETIME NULL,
  `Recordscol` VARCHAR(45) NULL,
  `generator_Type` CHAR(15) NULL,
  `service_ID` INT NULL,
  PRIMARY KEY (`record_ID`),
  INDEX `service_ID_idx` (`service_ID` ASC) VISIBLE,
  INDEX `generator_Type_idx` (`generator_Type` ASC) VISIBLE,
  CONSTRAINT `service_ID`
    FOREIGN KEY (`service_ID`)
    REFERENCES `Service_Providers` (`service_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `generator_Type`
    FOREIGN KEY (`generator_Type`)
    REFERENCES `Waste_Generator` (`generator_Type`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
