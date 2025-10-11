<?php

include 'config.php';

// 1. Insert into TICKET table first
$sql = "INSERT INTO ticket (employee_id, lab_room, status, priority) 
        VALUES ('7', 'ITS 201', 'Pending', 'normal')";
$connection->query($sql);
$ticket_id = $connection->insert_id; // Get the new ticket ID

// 2. Insert into REQUEST table for each selected concern
if (isset($_POST['concerns'])) {
    foreach ($_POST['concerns'] as $concern_id) {
        $sql = "INSERT INTO request (ticket_id, concern_id) 
                VALUES ('$ticket_id', '$concern_id')";
        $connection->query($sql);
    }
    echo "Ticket #$ticket_id created successfully!";
} else {
    include 'ticket.html';
}

?>