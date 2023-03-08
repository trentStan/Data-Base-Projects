CREATE DEFINER=`root`@`localhost` FUNCTION `retrieveCustomerNo`(p_customerNo varchar(30)) RETURNS int(11)
BEGIN

RETURN p_customerNo;
END