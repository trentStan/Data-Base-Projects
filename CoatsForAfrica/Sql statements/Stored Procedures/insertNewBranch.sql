CREATE DEFINER=`root`@`localhost` PROCEDURE `insertNewBranch`(IN `p_branchNo` VARCHAR(30), IN `p_location` VARCHAR(45), IN `p_address` VARCHAR(45))
INSERT INTO `Branch`(`branchNo`, `location`, `address`)  
    VAlUES (p_branchNo, p_location, p_address)