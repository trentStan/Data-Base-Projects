-- MySQL Script generated by MySQL Workbench
-- 07/16/21 17:36:22
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Jarzin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Jarzin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Jarzin` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `Jarzin` ;

-- -----------------------------------------------------
-- Table `Jarzin`.`Office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Office` (
  `officeID` INT NOT NULL AUTO_INCREMENT,
  `region` VARCHAR(50) NULL,
  `phoneNum` VARCHAR(50) NULL,
  `address` VARCHAR(50) NULL,
  PRIMARY KEY (`officeID`),
  UNIQUE INDEX `officeID_UNIQUE` (`officeID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Employee` (
  `empID` INT NOT NULL AUTO_INCREMENT,
  `lastName` VARCHAR(50) NULL,
  `firstName` VARCHAR(50) NULL,
  `extension` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `jobTitle` VARCHAR(50) NULL,
  `Office_officeID` INT NOT NULL,
  `superviseID` INT NULL,
  PRIMARY KEY (`empID`, `Office_officeID`),
  UNIQUE INDEX `empID_UNIQUE` (`empID` ASC),
  INDEX `fk_Employee_Office1_idx` (`Office_officeID` ASC),
  INDEX `superviseID_idx` (`superviseID` ASC),
  CONSTRAINT `fk_Employee_Office1`
    FOREIGN KEY (`Office_officeID`)
    REFERENCES `Jarzin`.`Office` (`officeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `superviseID`
    FOREIGN KEY (`superviseID`)
    REFERENCES `Jarzin`.`Employee` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Customer` (
  `custID` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(40) NULL,
  `phone_numbers` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `address` VARCHAR(50) NULL,
  `city` VARCHAR(45) NULL,
  `postcode` INT NULL,
  `creditLimit` FLOAT(7,2) NULL,
  `type` SET('reg', 'temp') NULL,
  `Employee_empID` INT NOT NULL,
  PRIMARY KEY (`custID`),
  UNIQUE INDEX `custID_UNIQUE` (`custID` ASC),
  INDEX `fk_Customer_Employee1_idx` (`Employee_empID` ASC),
  CONSTRAINT `fk_Customer_Employee1`
    FOREIGN KEY (`Employee_empID`)
    REFERENCES `Jarzin`.`Employee` (`empID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`Account`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Account` (
  `accID` INT NOT NULL AUTO_INCREMENT,
  `payDate` DATE NULL,
  `amtDue` FLOAT(7,2) NULL,
  `Customer_custID` INT NOT NULL,
  PRIMARY KEY (`accID`, `Customer_custID`),
  INDEX `fk_Account_Customer1_idx` (`Customer_custID` ASC),
  CONSTRAINT `fk_Account_Customer1`
    FOREIGN KEY (`Customer_custID`)
    REFERENCES `Jarzin`.`Customer` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`Order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Order` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `orderDate` DATE NULL,
  `deliverDate` VARCHAR(50) NULL,
  `deliverStatus` SET('delivered', 'to be delivered') NULL,
  `total` FLOAT(7,2) NULL,
  `Customer_custID` INT NOT NULL,
  PRIMARY KEY (`orderID`, `Customer_custID`),
  INDEX `fk_Order_Customer_idx` (`Customer_custID` ASC),
  CONSTRAINT `fk_Order_Customer`
    FOREIGN KEY (`Customer_custID`)
    REFERENCES `Jarzin`.`Customer` (`custID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`ProductLine`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`ProductLine` (
  `prodLineNo` INT NOT NULL AUTO_INCREMENT,
  `lineName` VARCHAR(50) NULL,
  `descript` TEXT NULL,
  PRIMARY KEY (`prodLineNo`),
  UNIQUE INDEX `prodLineNo_UNIQUE` (`prodLineNo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`Product` (
  `prodNo` INT NOT NULL AUTO_INCREMENT,
  `prodName` VARCHAR(50) NULL,
  `prodScale` VARCHAR(50) NULL,
  `prodVendor` VARCHAR(50) NULL,
  `prodDesc` TEXT NULL,
  `quantity` INT NULL,
  `ProductLine_prodLineNo` INT NOT NULL,
  PRIMARY KEY (`prodNo`, `ProductLine_prodLineNo`),
  UNIQUE INDEX `prodNo_UNIQUE` (`prodNo` ASC),
  INDEX `fk_Product_ProductLine1_idx` (`ProductLine_prodLineNo` ASC),
  CONSTRAINT `fk_Product_ProductLine1`
    FOREIGN KEY (`ProductLine_prodLineNo`)
    REFERENCES `Jarzin`.`ProductLine` (`prodLineNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Jarzin`.`OrderDetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jarzin`.`OrderDetail` (
  `Order_orderID` INT NOT NULL,
  `Product_prodNo` INT NOT NULL,
  `qtOrdered` INT NULL,
  `itemPrice` FLOAT(7,2) NULL,
  PRIMARY KEY (`Order_orderID`, `Product_prodNo`),
  INDEX `fk_OrderDetail_Product1_idx` (`Product_prodNo` ASC),
  CONSTRAINT `fk_OrderDetail_Order1`
    FOREIGN KEY (`Order_orderID`)
    REFERENCES `Jarzin`.`Order` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_OrderDetail_Product1`
    FOREIGN KEY (`Product_prodNo`)
    REFERENCES `Jarzin`.`Product` (`prodNo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
