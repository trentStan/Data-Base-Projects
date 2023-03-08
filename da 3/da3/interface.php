<?php
/*
if(isset($_SESSION)){
    header('Location: login.php');
}*/

$user = "root";
$pass = "";
$db = "jarzin";
$host = "localhost";
$conn = new mysqli($host, $user, $pass, $db);

if (!$conn) {
    die("database not connected") . mysqli_error($conn);
}
$result = $conn->query('call all_products();');

?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DA project</title>
</head>
<style>
    table {
        width: 65%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid lightgrey;
    }



    th,tr {
        text-align: left;
        height: 40px;

    }

    td {
        padding-left: 10px;
    }

    th {
        padding-left: 10px;
        background-color: lightgreen;
    }
</style>

<body>
    <a href="logout.php">Logout</a> <br>
    <h1>Products</h1> <br>
    <table id="stats">
        <tr id="head">
            <th>Product No.</th>
            <th>Name</th>
            <th>Scale</th>
            <th>Vendor</th>
            <th>Description</th>
            <th>Quantity</th>
            <th>Line no.</th>
        </tr>
        <? while ($row = $result->fetch_assoc()) { ?>
            <tr>
                <td><?echo $row['prodNo'];?></td>
                <td><?echo $row['prodName'];?></td>
                <td><?echo $row['prodScale'];?></td>
                <td><?echo $row['prodVendor'];?></td>
                <td><?echo $row['prodDesc'];?></td>
                <td><?echo $row['quantity'];?></td>
                <td><?echo $row['ProductLine_prodLineNo'];?></td>
            </tr>
        <? } ?>
    </table>
</body>

</html>