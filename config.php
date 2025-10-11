<?php
$host = "localhost";
$username = "root";
$password = "";
$database = "maintix";

$connection = new mysqli($host, $username, $password, $database, 3307);

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}
?>