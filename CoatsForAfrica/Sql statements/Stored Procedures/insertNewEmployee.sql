CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewEmployee`(p_empNo varchar(30) , p_empName varchar(45) , p_empSurname varchar(45) , p_salary varchar(45), p_jobDescription varchar(45) , p_branchNo nvarchar(45))
INSERT INTO `Employee`  
    VAlUES (p_empNo  , p_empName , p_empSurname , p_salary , p_jobDescription, p_branchNo)