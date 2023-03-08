CREATE DEFINER=`root`@`localhost` PROCEDURE `insertSupplier`(p_supplierNo varchar(30) , p_supplierName varchar(45) , p_description varchar(45))
INSERT INTO `Supplier`  
    VAlUES (p_supplierNo , p_supplierName , p_description)