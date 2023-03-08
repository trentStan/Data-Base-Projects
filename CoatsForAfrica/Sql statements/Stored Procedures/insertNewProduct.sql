CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewProduct`(p_productNo varchar(30) , p_prodName varchar(45) , p_prodDescript varchar(45) , p_supplierNo varchar(45))
INSERT INTO `Product`  
    VAlUES (p_productNo , p_prodName , p_prodDescript , p_supplierNo )