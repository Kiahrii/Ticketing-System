<?php

// include 'config.php';

// if (isset($_POST['login'])) {
//     $email = trim($connection->real_escape_string($_POST['email']));
//     $password = trim($_POST['password']);

//     // Check if account exists
//     $login_sql = "SELECT * FROM user_info WHERE username = '$email'";
//     $login_result = $connection->query($login_sql);

//     if ($login_result->num_rows === 1) {
//         $user = $login_result->fetch_assoc();

//         if (password_verify($password, $user['password_hash'])) {
//             echo "Login successful! Welcome back, " . $user['first_name'] . " " . $user['last_name'];
//             //include 'dashboard.html';
//         } else {
//             echo "Incorrect password.";
//             //include 'index.html';
//         }
//     } else {
//         echo "No account found with that email.";
//         //include 'index.html';
//     }
// } else {
//     include 'index.html';
// }

// // REGISTER PROCESSING
// if (isset($_POST['register'])) {
//     $firstname = trim($connection->real_escape_string($_POST['firstname']));
//     $lastname = trim($connection->real_escape_string($_POST['lastname']));
//     $tin = trim($connection->real_escape_string($_POST['tin']));
//     $department = trim($connection->real_escape_string($_POST['department']));
//     $email = trim($connection->real_escape_string($_POST['email']));
//     $password = password_hash($_POST['password'], PASSWORD_DEFAULT);

//     // CHECKS IF ACCOUNT ALREADY EXISTS
//     $check_sql = "SELECT * FROM user_info WHERE username = '$email' OR tin_no = '$tin'";
//     $result = $connection->query($check_sql);

//     if ($result->num_rows > 0) {
//         echo "Account Already Exists";
//     } else {
//         $sql = "INSERT INTO user_info (first_name, last_name, tin_no, department, username, password_hash) 
//                     VALUES ('$firstname', '$lastname', '$tin', '$department', '$email', '$password')";

//         if ($connection->query($sql) === TRUE) {
//             //echo "Registration successful!<br>";
//             //echo "Welcome, $firstname $lastname!<br>";
//         } else {
//             echo "Error: " . $connection->error;
//         }
//         include 'index.html';
//     }
// } else {
//     include 'index.html';
// }

include 'config.php';

if (isset($_POST['login'])) {
    $email = trim($connection->real_escape_string($_POST['email']));
    $password = trim($_POST['password']);

    echo "DEBUG - Email: $email<br>";
    echo "DEBUG - Password: $password<br>";

    $login_sql = "SELECT * FROM user_info WHERE username = '$email'";
    echo "DEBUG - SQL: $login_sql<br>";
    
    $login_result = $connection->query($login_sql);

    if ($login_result && $login_result->num_rows === 1) {
        $user = $login_result->fetch_assoc();
        echo "DEBUG - User found: " . $user['username'] . "<br>";
        echo "DEBUG - Stored hash: " . $user['password_hash'] . "<br>";
        
        if (password_verify($password, $user['password_hash'])) {
            echo "SUCCESS: Login successful!";
        } else {
            echo "ERROR: Incorrect password.";
        }
    } else {
        echo "ERROR: No account found or query failed.";
    }
    exit(); // Stop here to see the debug output
} else {
    //include 'index.html';
}

?>
