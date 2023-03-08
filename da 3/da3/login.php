<?php

$user = "root";
$pass = "";
$db = "jarzin";
$host = "localhost";
$conn = new mysqli($host, $user, $pass, $db);

if (!$conn) {
    die("database not connected") . mysqli_error($conn);
}

if(isset($_POST['email']) ){
    $email = $_POST['email'];
    $pass = $_POST['psw'];
    $sql = "SELECT `email`, `password` FROM customer WHERE `email`= '$email' ";
    $result = $conn->query($sql);

    while($row = $result->fetch_assoc()){
        if($pass == $row['password']){
            session_start();
            $_SESSION['email'] = $email;            
            header('Location: interface.php');
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Question 3</title>
    <link rel="stylesheet" href="question3.css">
</head>

<body>
    <fieldset>
        <legend>Login</legend>
                <form action="<?echo $_SERVER['PHP_SELF']?>" method="post" onsubmit="return validate()">
                    <table>
                    <tr><td> </td></tr>    
                    <tr>
                            <td colspan="2">Email: <br>
                                <input type="email" placeholder="Enter your email" name="email" id="email">
                            </td>
                        </tr>
                        <tr>

                        </tr>
                        <tr>
                            <td colspan="2">Password: <br>
                                <input type="password" placeholder="Enter your password" name="psw" id="psw">
                            </td>
                        </tr>
                        <tr>

                            <td colspan="2" class="button"><button type="submit">Login</button></td>
                        </tr>
                    </table>
                </form>
    </fieldset>



</body>
<script>
    var email = document.getElementById('email');
    var password = document.getElementById('psw')

    function validate() {
        if (email.value == "") {
            alert('Please provide your email');
            return false;
        }
        if (password.value == "") {
            alert('Please provide password')
            return false;
        } else {
            return true;
        }
    }
</script>

</html>