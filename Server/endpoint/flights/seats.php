<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';

setCorsHeaders();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    sendError("Method not allowed. Use GET.", 405);
}

if (empty($_GET['flight_id'])) {
    sendError("flight_id is required.", 400);
}

$flight_id = (int) $_GET['flight_id'];
$conn = getConnection();

$sql = "SELECT seat_number FROM bookings WHERE flight_id = $flight_id AND status != 'Cancelled'";
$result = $conn->query($sql);

$occupied = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        if (!empty($row['seat_number'])) {
            $occupied[] = $row['seat_number'];
        }
    }
}

sendResponse(["occupied_seats" => $occupied]);
$conn->close();
?>
