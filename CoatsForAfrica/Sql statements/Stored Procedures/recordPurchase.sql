CREATE DEFINER=`root`@`localhost` PROCEDURE `recordPurchase`(p_productNo VARCHAR(30), p_customerNo varchar(30), p_branchNo VARCHAR(30))
BEGIN
     
    INSERT INTO `ProductBought` VALUES (p_productNo, p_customerNo);
    UPDATE `Customer` SET numProductsBought = numProductsBought + 1;
	UPDATE `BranchStock` SET numStock = numStock - 1 
    WHERE `branchstock`.`Product_productNo` = p_productNo AND `branchstock`.`Branch_branchNo` = p_branchNo;
END