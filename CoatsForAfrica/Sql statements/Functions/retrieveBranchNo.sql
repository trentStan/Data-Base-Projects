CREATE DEFINER=`root`@`localhost` FUNCTION `retrieveBranchNo`(p_branchNo varchar(30)) RETURNS int(11)
BEGIN

RETURN p_branchNo;
END