CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `execmanager` AS
    SELECT 
        `branch`.`branchNo` AS `branchNo`,
        `branch`.`location` AS `location`,
        `branch`.`address` AS `address`,
        `employee`.`empNo` AS `empNo`,
        `employee`.`empName` AS `empName`,
        `employee`.`empSurname` AS `empSurname`,
        `employee`.`salary` AS `salary`,
        `employee`.`jobDescription` AS `jobDescription`,
        `employee`.`Branch_branchNo` AS `Branch_branchNo`,
        `product`.`productNo` AS `productNo`,
        `product`.`prodName` AS `prodName`,
        `product`.`prodDescript` AS `prodDescript`,
        `product`.`Supplier_supplierNo` AS `Supplier_supplierNo`,
        `supplier`.`supplierNo` AS `supplierNo`,
        `supplier`.`supplierName` AS `supplierName`,
        `supplier`.`description` AS `description`,
        `customer`.`customerNo` AS `customerNo`,
        `customer`.`custName` AS `custName`,
        `customer`.`custSurname` AS `custSurname`,
        `customer`.`numProductsBought` AS `numProductsBought`,
        `customer`.`email` AS `email`,
        TOTALPRODUCTSBOUGHT() AS `totalProductsBought()`
    FROM
        ((((`branch`
        JOIN `employee`)
        JOIN `product`)
        JOIN `supplier`)
        JOIN `customer`)