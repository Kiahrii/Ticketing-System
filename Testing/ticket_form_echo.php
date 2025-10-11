<?php

$concerns_list = [
    1 => "Missing Keyboard",
    2 => "Missing Mouse", 
    3 => "Missing Cables",
    4 => "Non-working Keyboard",
    5 => "Non-working Mouse",
    6 => "Non-working PCs",
    7 => "Need Cleaning",
    8 => "Software Installation",
    9 => "Others"
];

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    echo "<h2>You selected (ID numbers):</h2>";
    
        if (isset($_POST['concerns'])) {
            foreach ($_POST['concerns'] as $concern_id) {
                echo "✓ ID: " . $concern_id . " - " . $concerns_list[$concern_id] . "<br>";
            }

            echo "<br><strong>Concern IDs for database: " . implode(", ", $_POST['concerns']) . "</strong>";
            echo "<br><a href='ticket.html'>Submit another ticket</a>";
        }
        else {
            include 'ticket.html';
        } 

    }else {
        include 'ticket.html';
    }
    
?>