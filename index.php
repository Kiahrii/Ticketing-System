<?php

include 'config.php';

// REGISTER PROCESSING
if (isset($_POST['register'])) {
    $firstname = trim($connection->real_escape_string($_POST['firstname']));
    $lastname = trim($connection->real_escape_string($_POST['lastname']));
    $tin = trim($connection->real_escape_string($_POST['tin']));
    $department = trim($connection->real_escape_string($_POST['Department']));
    $email = trim($connection->real_escape_string($_POST['email']));
    $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

    // CHECKS IF ACCOUNT ALREADY EXISTS
    $check_sql = "SELECT * FROM user_info WHERE username = '$email' OR tin_no = '$tin'";
    $result = $connection->query($check_sql);

    if ($result->num_rows > 0) {
        echo "Account Already Exists";
    } else {
        $sql = "INSERT INTO user_info (first_name, last_name, tin_no, department, username, password_hash) 
                    VALUES ('$firstname', '$lastname', '$tin', '$department', '$email', '$password')";

        if ($connection->query($sql) === TRUE) {
            //echo "Registration successful!<br>";
            //echo "Welcome, $firstname $lastname!<br>";
        } else {
            echo "Error: " . $connection->error;
        }
        include 'index.html';
    }
} else {
    include 'index.html';
}
?>