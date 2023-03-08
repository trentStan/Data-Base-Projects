CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `boughtproductsbycust` AS
    SELECT 
        `customer`.`customerNo` AS `customerNo`,
        `customer`.`custName` AS `custName`,
        `customer`.`custSurname` AS `custSurname`,
        `product`.`productNo` AS `productNo`,
        `product`.`prodName` AS `prodName`,
        `product`.`prodDescript` AS `prodDescript`
    FROM
        ((`product`
        JOIN `customer`)
        JOIN `productbought`)
    WHERE
        ((`product`.`productNo` = `productbought`.`Product_productNo`)
            AND (`customer`.`customerNo` = `productbought`.`Customer_customerNo`))
    GROUP BY `customer`.`customerNo`