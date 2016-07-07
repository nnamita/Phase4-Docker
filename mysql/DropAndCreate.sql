SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `recap` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `recap` ;

DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_T` (
  `BIBLIOGRAPHIC_ID` INT NOT NULL AUTO_INCREMENT,
  `CONTENT` LONGBLOB NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `CREATED_BY` VARCHAR(45) NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_BY` VARCHAR(45) NOT NULL ,
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`OWNING_INST_ID`, `OWNING_INST_BIB_ID`) ,
  KEY `BIBLIOGRAPHIC_ID` (`BIBLIOGRAPHIC_ID`),
  INDEX `BIBLIOGRAPHIC_OWNING_INST_ID_FK` (`OWNING_INST_ID` ASC) ,
  CONSTRAINT `BIBLIOGRAPHIC_OWNING_INST_ID_FK`
    FOREIGN KEY (`OWNING_INST_ID` )
    REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `recap`.`HOLDINGS_T`;
-- -----------------------------------------------------
-- Table `recap`.`HOLDINGS_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`HOLDINGS_T` (
  `HOLDINGS_ID` INT NOT NULL AUTO_INCREMENT ,
  `CONTENT` BLOB NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `CREATED_BY` VARCHAR(45) NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_BY` VARCHAR(45) NOT NULL ,
  `OWNING_INST_HOLDINGS_ID` VARCHAR(45) NULL ,
  PRIMARY KEY (`HOLDINGS_ID`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `recap`.`ITEM_T`;
-- -----------------------------------------------------
-- Table `recap`.`ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`ITEM_T` (
  `ITEM_ID` INT NOT NULL AUTO_INCREMENT,
  `BAR_CODE` VARCHAR(45) NOT NULL ,
  `CUSTOMER_CODE` VARCHAR(45) NOT NULL ,
  `HOLDINGS_ID` INT NOT NULL ,
  `CALL_NUMBER` VARCHAR(2000) NULL ,
  `CALL_NUMBER_TYPE` VARCHAR(80) NULL ,
  `ITEM_AVAIL_STATUS_ID` INT NOT NULL ,
  `COPY_NUMBER` INT NULL ,
  `OWNING_INST_ID` INT NOT NULL ,
  `COLLECTION_GROUP_ID` INT NOT NULL ,
  `CREATED_DATE` DATETIME NOT NULL ,
  `CREATED_BY` VARCHAR(45) NOT NULL ,
  `LAST_UPDATED_DATE` DATETIME NOT NULL ,
  `LAST_UPDATED_BY` VARCHAR(45) NOT NULL ,
  `USE_RESTRICTIONS` VARCHAR(2000) NULL ,
  `VOLUME_PART_YEAR` VARCHAR(2000) NULL ,
  `OWNING_INST_ITEM_ID` VARCHAR(45) NOT NULL ,
  `NOTES_ID` INT NULL ,
  PRIMARY KEY (`OWNING_INST_ITEM_ID`, `OWNING_INST_ID`) ,
  KEY `ITEM_ID` (`ITEM_ID`),
  INDEX `HOLDINGS_ID_FK_idx` (`HOLDINGS_ID` ASC) ,
  INDEX `ITEM_AVAIL_STATUS_ID_FK_idx` (`ITEM_AVAIL_STATUS_ID` ASC) ,
  INDEX `OWNING_INST_FK_idx` (`OWNING_INST_ID` ASC) ,
  INDEX `COLLECTION_TYPE_FK_idx` (`COLLECTION_GROUP_ID` ASC) ,
  UNIQUE INDEX `BAR_CODE` (`BAR_CODE` ASC),
  CONSTRAINT `ITEM_HOLDINGS_ID_FK`
    FOREIGN KEY (`HOLDINGS_ID` )
    REFERENCES `recap`.`HOLDINGS_T` (`HOLDINGS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_AVAIL_STATUS_ID_FK`
    FOREIGN KEY (`ITEM_AVAIL_STATUS_ID` )
    REFERENCES `recap`.`ITEM_STATUS_T` (`ITEM_STATUS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_OWNING_INST_ID_FK`
    FOREIGN KEY (`OWNING_INST_ID` )
    REFERENCES `recap`.`INSTITUTION_T` (`INSTITUTION_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ITEM_COLLECTION_GROUP_FK`
    FOREIGN KEY (`COLLECTION_GROUP_ID` )
    REFERENCES `recap`.`COLLECTION_GROUP_T` (`COLLECTION_GROUP_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_HOLDINGS_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_HOLDINGS_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_HOLDINGS_T` (
  `BIBLIOGRAPHIC_HOLDINGS_ID` INT NOT NULL AUTO_INCREMENT ,
  `OWNING_INST_ID` INT NOT NULL ,
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL ,
  `HOLDINGS_ID` INT NOT NULL ,
  PRIMARY KEY (`BIBLIOGRAPHIC_HOLDINGS_ID`) ,
  INDEX `HOLDINGS_ID_idx` (`HOLDINGS_ID` ASC) ,
  INDEX `OWNING_INST_ID_idx` (`OWNING_INST_ID` ASC) ,
  INDEX `OWNING_INST_BIB_ID_idx` (`OWNING_INST_BIB_ID` ASC) ,
  CONSTRAINT `HOLDINGS_ID_FK`
    FOREIGN KEY (`HOLDINGS_ID` )
    REFERENCES `recap`.`HOLDINGS_T` (`HOLDINGS_ID` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


DROP TABLE IF EXISTS `recap`.`BIBLIOGRAPHIC_ITEM_T`;
-- -----------------------------------------------------
-- Table `recap`.`BIBLIOGRAPHIC_ITEM_T`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `recap`.`BIBLIOGRAPHIC_ITEM_T` (
  `BIBLIOGRAPHIC_ITEM_ID` INT NOT NULL AUTO_INCREMENT ,
  `OWNING_INST_BIB_ID` VARCHAR(45) NOT NULL ,
  `BIB_INST_ID` INT NOT NULL ,
  `ITEM_INST_ID` INT NOT NULL ,
  `OWNING_INST_ITEM_ID` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`BIBLIOGRAPHIC_ITEM_ID`),
  INDEX `OWNING_INST_BIB_ID_idx` (`OWNING_INST_BIB_ID` ASC) ,
  INDEX `BIB_INST_ID_idx` (`BIB_INST_ID` ASC) ,
  INDEX `ITEM_INST_ID_idx` (`ITEM_INST_ID` ASC) ,
  INDEX `OWNING_INST_ITEM_ID_idx` (`OWNING_INST_ITEM_ID` ASC))
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
