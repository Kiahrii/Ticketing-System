<?php

include 'config.php';

if (isset($_POST['submit_issues'])) {
    $room = ($_POST['room']);
    $priority = ($_POST['priority']);

    $sql = "INSERT INTO ticket (employee_id, lab_room, priority) 
        VALUES ('2', '$room', '$priority')";
    $connection->query($sql);
    $ticket_id = $connection->insert_id;

    if (isset($_POST['issues'])) {
        foreach ($_POST['issues'] as $concern_id) {
            $sql = "INSERT INTO request (ticket_id, concern_id) 
                VALUES ('$ticket_id', '$concern_id')";
            $connection->query($sql);
        }
        echo "Ticket #$ticket_id created successfully!";
    } else {
        include 'ticket.html';
    }
} else {
    include 'ticket.html';
}
?>
