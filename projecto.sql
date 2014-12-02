SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `job` VARCHAR(45) NULL,
  `pass` VARCHAR(45) NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Meeting` (
  `title` VARCHAR(45) NULL,
  `desiredOutcome` VARCHAR(45) NULL,
  `date` TIMESTAMP NULL,
  `location` VARCHAR(45) NULL,
  `idMeeting` INT NOT NULL,
  PRIMARY KEY (`idMeeting`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Discussion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Discussion` (
  `idAItem` INT NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ActionItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ActionItem` (
  `nome` VARCHAR(45) NULL,
  `done` TINYINT(1) NULL,
  `User_idUser` INT NOT NULL,
  `Meeting_User_idUser` INT NOT NULL,
  CONSTRAINT `fk_ActionItem_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`KeyDecision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`KeyDecision` (
  `idItem` INT NOT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Group` (
  `idGroup` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idGroup`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ActionItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ActionItem` (
  `nome` VARCHAR(45) NULL,
  `done` TINYINT(1) NULL,
  `User_idUser` INT NOT NULL,
  `Meeting_User_idUser` INT NOT NULL,
  CONSTRAINT `fk_ActionItem_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Agenda Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Agenda Item` (
  `idAItem` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `Meeting_User_idUser` INT NOT NULL,
  `KeyDecision_idItem` INT NOT NULL,
  `discussion` MEDIUMTEXT NULL,
  `Discussion_idAItem` INT NOT NULL,
  PRIMARY KEY (`idAItem`),
  INDEX `fk_Agenda Item_KeyDecision1_idx` (`KeyDecision_idItem` ASC),
  INDEX `fk_Agenda Item_Discussion1_idx` (`Discussion_idAItem` ASC),
  CONSTRAINT `fk_Agenda Item_KeyDecision1`
    FOREIGN KEY (`KeyDecision_idItem`)
    REFERENCES `mydb`.`KeyDecision` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Agenda Item_Discussion1`
    FOREIGN KEY (`Discussion_idAItem`)
    REFERENCES `mydb`.`Discussion` (`idAItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Meeting` (
  `User_idUser` INT NOT NULL,
  `Meeting_idMeeting` INT NOT NULL,
  PRIMARY KEY (`User_idUser`, `Meeting_idMeeting`),
  INDEX `fk_User_has_Meeting_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_Meeting_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Meeting1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Meeting1` (
  `User_idUser` INT NOT NULL,
  `Meeting_User_idUser` INT NOT NULL,
  PRIMARY KEY (`User_idUser`, `Meeting_User_idUser`),
  INDEX `fk_User_has_Meeting1_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_Meeting1_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group_has_User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Group_has_User` (
  `Group_idGroup` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  INDEX `fk_Group_has_User_User1_idx` (`User_idUser` ASC),
  INDEX `fk_Group_has_User_Group1_idx` (`Group_idGroup` ASC),
  CONSTRAINT `fk_Group_has_User_Group1`
    FOREIGN KEY (`Group_idGroup`)
    REFERENCES `mydb`.`Group` (`idGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Group_has_User_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Meeting2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Meeting2` (
  `User_idUser` INT NULL,
  `Meeting_idMeeting` INT NULL,
  `leader` INT NULL,
  INDEX `fk_User_has_Meeting2_Meeting1_idx` (`Meeting_idMeeting` ASC),
  INDEX `fk_User_has_Meeting2_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_Meeting2_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Meeting2_Meeting1`
    FOREIGN KEY (`Meeting_idMeeting`)
    REFERENCES `mydb`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
