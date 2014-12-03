SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `username` VARCHAR(45) NULL,
  `job` VARCHAR(45) NULL,
  `pass` VARCHAR(45) NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Meeting` (
  `idMeeting` INT NOT NULL,
  `desiredOutcome` VARCHAR(350) NULL,
  `title` VARCHAR(45) NULL,
  `date` TIMESTAMP NULL,
  `location` VARCHAR(45) NULL,
  `active` TINYINT(1) NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idMeeting`),
  INDEX `fk_Meeting_User_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_Meeting_User`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
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
  INDEX `fk_User_has_Meeting_Meeting1_idx` (`Meeting_idMeeting` ASC),
  INDEX `fk_User_has_Meeting_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_Meeting_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Meeting_Meeting1`
    FOREIGN KEY (`Meeting_idMeeting`)
    REFERENCES `mydb`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Item`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Item` (
  `idItem` INT NOT NULL,
  `description` VARCHAR(100) NULL,
  `idMeeting` INT NOT NULL,
  PRIMARY KEY (`idItem`),
  INDEX `fk_Item_Meeting1_idx` (`idMeeting` ASC),
  CONSTRAINT `fk_Item_Meeting1`
    FOREIGN KEY (`idMeeting`)
    REFERENCES `mydb`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ActionItem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ActionItem` (
  `idActionItem` INT NOT NULL,
  `description` VARCHAR(100) NULL,
  `done` TINYINT(1) NULL,
  `User_idUser` INT NOT NULL,
  `Meeting_idMeeting` INT NOT NULL,
  PRIMARY KEY (`idActionItem`),
  INDEX `fk_ActionItem_User1_idx` (`User_idUser` ASC),
  INDEX `fk_ActionItem_Meeting1_idx` (`Meeting_idMeeting` ASC),
  CONSTRAINT `fk_ActionItem_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ActionItem_Meeting1`
    FOREIGN KEY (`Meeting_idMeeting`)
    REFERENCES `mydb`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Group` (
  `idGroup` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`idGroup`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`User_has_Group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`User_has_Group` (
  `User_idUser` INT NOT NULL,
  `Group_idGroup` INT NOT NULL,
  PRIMARY KEY (`User_idUser`, `Group_idGroup`),
  INDEX `fk_User_has_Group_Group1_idx` (`Group_idGroup` ASC),
  INDEX `fk_User_has_Group_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_User_has_Group_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_User_has_Group_Group1`
    FOREIGN KEY (`Group_idGroup`)
    REFERENCES `mydb`.`Group` (`idGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Group_has_Meeting`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Group_has_Meeting` (
  `Group_idGroup` INT NOT NULL,
  `Meeting_idMeeting` INT NOT NULL,
  PRIMARY KEY (`Group_idGroup`, `Meeting_idMeeting`),
  INDEX `fk_Group_has_Meeting_Meeting1_idx` (`Meeting_idMeeting` ASC),
  INDEX `fk_Group_has_Meeting_Group1_idx` (`Group_idGroup` ASC),
  CONSTRAINT `fk_Group_has_Meeting_Group1`
    FOREIGN KEY (`Group_idGroup`)
    REFERENCES `mydb`.`Group` (`idGroup`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Group_has_Meeting_Meeting1`
    FOREIGN KEY (`Meeting_idMeeting`)
    REFERENCES `mydb`.`Meeting` (`idMeeting`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`KeyDecision`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`KeyDecision` (
  `idKeyDecision` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `finished` TINYINT(1) NULL,
  `idItem` INT NOT NULL,
  PRIMARY KEY (`idKeyDecision`),
  INDEX `fk_KeyDecision_Item1_idx` (`idItem` ASC),
  CONSTRAINT `fk_KeyDecision_Item1`
    FOREIGN KEY (`idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Discussion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Discussion` (
  `idDiscussion` INT NOT NULL,
  `content` VARCHAR(500) NULL,
  `active` TINYINT(1) NULL,
  `Item_idItem` INT NOT NULL,
  `User_idUser` INT NOT NULL,
  PRIMARY KEY (`idDiscussion`),
  INDEX `fk_Discussion_Item1_idx` (`Item_idItem` ASC),
  INDEX `fk_Discussion_User1_idx` (`User_idUser` ASC),
  CONSTRAINT `fk_Discussion_Item1`
    FOREIGN KEY (`Item_idItem`)
    REFERENCES `mydb`.`Item` (`idItem`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Discussion_User1`
    FOREIGN KEY (`User_idUser`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
