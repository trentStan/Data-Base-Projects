-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 17, 2020 at 11:03 PM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `coatsforafrica`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `addStock`(p_productNo varchar(30), p_branchNo varchar(30), addedStock varchar(30))
UPDATE `BranchStock` SET numStock = numStock + addedStock WHERE Product_productNo = p_productNo AND Branch_branchNo = p_branchNo$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewBranch`(IN `p_branchNo` VARCHAR(30), IN `p_location` VARCHAR(45), IN `p_address` VARCHAR(45))
INSERT INTO `Branch`(`branchNo`, `location`, `address`)  
    VAlUES (p_branchNo, p_location, p_address)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewCustomer`(p_customerNo varchar(30) , p_custName varchar(45) , p_custSurname varchar(45) , p_email varchar(45))
INSERT INTO `Customer` (customerNo, custName, custSurname, email) 
    VAlUES (p_customerNo  , p_custName , p_custSurname , p_email)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewEmployee`(p_empNo varchar(30) , p_empName varchar(45) , p_empSurname varchar(45) , p_salary varchar(45), p_jobDescription varchar(45) , p_branchNo nvarchar(45))
INSERT INTO `Employee`  
    VAlUES (p_empNo  , p_empName , p_empSurname , p_salary , p_jobDescription, p_branchNo)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewProduct`(p_productNo varchar(30) , p_prodName varchar(45) , p_prodDescript varchar(45) , p_supplierNo varchar(45))
INSERT INTO `Product`  
    VAlUES (p_productNo , p_prodName , p_prodDescript , p_supplierNo )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSupplier`(p_supplierNo varchar(30) , p_supplierName varchar(45) , p_description varchar(45))
INSERT INTO `Supplier`  
    VAlUES (p_supplierNo , p_supplierName , p_description)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `recordPurchase`(p_productNo VARCHAR(30), p_customerNo varchar(30), p_branchNo VARCHAR(30))
BEGIN
     
    INSERT INTO `ProductBought` VALUES (p_productNo, p_customerNo);
    UPDATE `Customer` SET numProductsBought = numProductsBought + 1;
	UPDATE `BranchStock` SET numStock = numStock - 1 
    WHERE `branchstock`.`Product_productNo` = p_productNo AND `branchstock`.`Branch_branchNo` = p_branchNo;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `retrieveBranchNo`(p_branchNo varchar(30)) RETURNS int(11)
BEGIN

RETURN p_branchNo;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `retrieveCustomerNo`(p_customerNo varchar(30)) RETURNS int(11)
BEGIN

RETURN p_customerNo;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `totalProductsBought`() RETURNS int(11)
BEGIN
	
RETURN (SELECT SUM(numProductsBought) FROM `Customer`);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `boughtproductsbycust`
--
CREATE TABLE IF NOT EXISTS `boughtproductsbycust` (
`customerNo` varchar(30)
,`custName` varchar(45)
,`custSurname` varchar(45)
,`productNo` varchar(30)
,`prodName` varchar(45)
,`prodDescript` varchar(45)
);
-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE IF NOT EXISTS `branch` (
  `branchNo` varchar(30) NOT NULL,
  `location` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  PRIMARY KEY (`branchNo`),
  UNIQUE KEY `branchNo_UNIQUE` (`branchNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branchNo`, `location`, `address`) VALUES
('E1', 'Maynardville', '21 Jump Street, Wynberg');

-- --------------------------------------------------------

--
-- Table structure for table `branchstock`
--

CREATE TABLE IF NOT EXISTS `branchstock` (
  `Product_productNo` varchar(30) NOT NULL,
  `Branch_branchNo` varchar(30) NOT NULL,
  `numStock` int(11) NOT NULL,
  PRIMARY KEY (`Product_productNo`,`Branch_branchNo`),
  KEY `fk_Product_has_Branch_Branch1_idx` (`Branch_branchNo`),
  KEY `fk_Product_has_Branch_Product1_idx` (`Product_productNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `branchstock`
--

INSERT INTO `branchstock` (`Product_productNo`, `Branch_branchNo`, `numStock`) VALUES
('P1', 'E1', 100);

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customerNo` varchar(30) NOT NULL,
  `custName` varchar(45) NOT NULL,
  `custSurname` varchar(45) NOT NULL,
  `numProductsBought` int(11) NOT NULL DEFAULT '0',
  `email` varchar(45) NOT NULL,
  PRIMARY KEY (`customerNo`),
  UNIQUE KEY `customerNo_UNIQUE` (`customerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerNo`, `custName`, `custSurname`, `numProductsBought`, `email`) VALUES
('C1', 'Matthew', 'Singh', 0, 'ms@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE IF NOT EXISTS `employee` (
  `empNo` varchar(30) NOT NULL,
  `empName` varchar(45) NOT NULL,
  `empSurname` varchar(45) NOT NULL,
  `salary` double NOT NULL,
  `jobDescription` varchar(45) NOT NULL,
  `Branch_branchNo` varchar(30) NOT NULL,
  PRIMARY KEY (`empNo`,`Branch_branchNo`),
  UNIQUE KEY `empNo_UNIQUE` (`empNo`),
  KEY `fk_Employee_Branch2_idx` (`Branch_branchNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`empNo`, `empName`, `empSurname`, `salary`, `jobDescription`, `Branch_branchNo`) VALUES
('E1', 'Johnny', 'Mongrel', 3400, 'Teller', 'E1');

-- --------------------------------------------------------

--
-- Stand-in structure for view `execmanager`
--
CREATE TABLE IF NOT EXISTS `execmanager` (
`branchNo` varchar(30)
,`location` varchar(45)
,`address` varchar(45)
,`empNo` varchar(30)
,`empName` varchar(45)
,`empSurname` varchar(45)
,`salary` double
,`jobDescription` varchar(45)
,`Branch_branchNo` varchar(30)
,`productNo` varchar(30)
,`prodName` varchar(45)
,`prodDescript` varchar(45)
,`Supplier_supplierNo` varchar(30)
,`supplierNo` varchar(30)
,`supplierName` varchar(45)
,`description` varchar(45)
,`customerNo` varchar(30)
,`custName` varchar(45)
,`custSurname` varchar(45)
,`numProductsBought` int(11)
,`email` varchar(45)
,`totalProductsBought()` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE IF NOT EXISTS `product` (
  `productNo` varchar(30) NOT NULL,
  `prodName` varchar(45) NOT NULL,
  `prodDescript` varchar(45) NOT NULL,
  `Supplier_supplierNo` varchar(30) NOT NULL,
  PRIMARY KEY (`productNo`,`Supplier_supplierNo`),
  UNIQUE KEY `productNo_UNIQUE` (`productNo`),
  KEY `fk_Product_Supplier2_idx` (`Supplier_supplierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productNo`, `prodName`, `prodDescript`, `Supplier_supplierNo`) VALUES
('P1', 'Air Jordan mark 2', 'Basketball shoes', 'S2');

-- --------------------------------------------------------

--
-- Table structure for table `productbought`
--

CREATE TABLE IF NOT EXISTS `productbought` (
  `Product_productNo` varchar(30) NOT NULL,
  `Customer_customerNo` varchar(30) NOT NULL,
  PRIMARY KEY (`Product_productNo`,`Customer_customerNo`),
  KEY `fk_Product_has_Customer_Customer1_idx` (`Customer_customerNo`),
  KEY `fk_Product_has_Customer_Product1_idx` (`Product_productNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `productbought`
--

INSERT INTO `productbought` (`Product_productNo`, `Customer_customerNo`) VALUES
('P1', 'C1');

-- --------------------------------------------------------

--
-- Stand-in structure for view `stockbybranch`
--
CREATE TABLE IF NOT EXISTS `stockbybranch` (
`prodName` varchar(45)
,`productNo` varchar(30)
,`location` varchar(45)
,`numStock` int(11)
);
-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

CREATE TABLE IF NOT EXISTS `supplier` (
  `supplierNo` varchar(30) NOT NULL,
  `supplierName` varchar(45) NOT NULL,
  `description` varchar(45) NOT NULL,
  PRIMARY KEY (`supplierNo`),
  UNIQUE KEY `supplierNo_UNIQUE` (`supplierNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierNo`, `supplierName`, `description`) VALUES
('S1', 'Swaggers', 'UK Trench Coats'),
('S2', 'Nike', 'Footwear');

-- --------------------------------------------------------

--
-- Structure for view `boughtproductsbycust`
--
DROP TABLE IF EXISTS `boughtproductsbycust`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `boughtproductsbycust` AS select `customer`.`customerNo` AS `customerNo`,`customer`.`custName` AS `custName`,`customer`.`custSurname` AS `custSurname`,`product`.`productNo` AS `productNo`,`product`.`prodName` AS `prodName`,`product`.`prodDescript` AS `prodDescript` from ((`product` join `customer`) join `productbought`) where ((`product`.`productNo` = `productbought`.`Product_productNo`) and (`customer`.`customerNo` = `productbought`.`Customer_customerNo`)) group by `customer`.`customerNo`;

-- --------------------------------------------------------

--
-- Structure for view `execmanager`
--
DROP TABLE IF EXISTS `execmanager`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `execmanager` AS select `branch`.`branchNo` AS `branchNo`,`branch`.`location` AS `location`,`branch`.`address` AS `address`,`employee`.`empNo` AS `empNo`,`employee`.`empName` AS `empName`,`employee`.`empSurname` AS `empSurname`,`employee`.`salary` AS `salary`,`employee`.`jobDescription` AS `jobDescription`,`employee`.`Branch_branchNo` AS `Branch_branchNo`,`product`.`productNo` AS `productNo`,`product`.`prodName` AS `prodName`,`product`.`prodDescript` AS `prodDescript`,`product`.`Supplier_supplierNo` AS `Supplier_supplierNo`,`supplier`.`supplierNo` AS `supplierNo`,`supplier`.`supplierName` AS `supplierName`,`supplier`.`description` AS `description`,`customer`.`customerNo` AS `customerNo`,`customer`.`custName` AS `custName`,`customer`.`custSurname` AS `custSurname`,`customer`.`numProductsBought` AS `numProductsBought`,`customer`.`email` AS `email`,`totalProductsBought`() AS `totalProductsBought()` from ((((`branch` join `employee`) join `product`) join `supplier`) join `customer`);

-- --------------------------------------------------------

--
-- Structure for view `stockbybranch`
--
DROP TABLE IF EXISTS `stockbybranch`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stockbybranch` AS select `product`.`prodName` AS `prodName`,`product`.`productNo` AS `productNo`,`branch`.`location` AS `location`,`branchstock`.`numStock` AS `numStock` from ((`branch` join `branchstock`) join `product`) where ((`branchstock`.`Product_productNo` = `product`.`productNo`) and (`branchstock`.`Branch_branchNo` = `branch`.`branchNo`)) group by `product`.`productNo`;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `branchstock`
--
ALTER TABLE `branchstock`
  ADD CONSTRAINT `fk_Product_has_Branch_Branch1` FOREIGN KEY (`Branch_branchNo`) REFERENCES `branch` (`branchNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Product_has_Branch_Product1` FOREIGN KEY (`Product_productNo`) REFERENCES `product` (`productNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `fk_Employee_Branch2` FOREIGN KEY (`Branch_branchNo`) REFERENCES `branch` (`branchNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `fk_Product_Supplier2` FOREIGN KEY (`Supplier_supplierNo`) REFERENCES `supplier` (`supplierNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `productbought`
--
ALTER TABLE `productbought`
  ADD CONSTRAINT `fk_Product_has_Customer_Customer1` FOREIGN KEY (`Customer_customerNo`) REFERENCES `customer` (`customerNo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Product_has_Customer_Product1` FOREIGN KEY (`Product_productNo`) REFERENCES `product` (`productNo`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
