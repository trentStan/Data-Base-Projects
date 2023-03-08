CREATE DEFINER=`root`@`localhost` FUNCTION `totalProductsBought`() RETURNS int(11)
BEGIN
	
RETURN (SELECT SUM(numProductsBought) FROM `Customer`);
END