<?php

$_SESSION['email'] = null;
$_SESSION['psw'] = null;

session_destroy();

header('Location: login.php');

?>