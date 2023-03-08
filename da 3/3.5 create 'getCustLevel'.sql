CREATE PROCEDURE `getCustLevel`()
BEGIN
SELECT `custID`,`type` FROM customer;
END