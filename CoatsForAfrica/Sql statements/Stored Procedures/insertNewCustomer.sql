CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewCustomer`(p_customerNo varchar(30) , p_custName varchar(45) , p_custSurname varchar(45) , p_email varchar(45))
INSERT INTO `Customer` (customerNo, custName, custSurname, email) 
    VAlUES (p_customerNo  , p_custName , p_custSurname , p_email)