CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `stockbybranch` AS
    SELECT 
        `product`.`prodName` AS `prodName`,
        `product`.`productNo` AS `productNo`,
        `branch`.`location` AS `location`,
        `branchstock`.`numStock` AS `numStock`
    FROM
        ((`branch`
        JOIN `branchstock`)
        JOIN `product`)
    WHERE
        ((`branchstock`.`Product_productNo` = `product`.`productNo`)
            AND (`branchstock`.`Branch_branchNo` = `branch`.`branchNo`))
    GROUP BY `product`.`productNo`