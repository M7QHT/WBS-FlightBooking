<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

$authUser = requireAuth();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    sendError("Method not allowed. Use GET.", 405);
}

$conn    = getConnection();
$user_id = (int) $authUser['user_id'];

$sql = "SELECT b.id, b.passenger_name, b.passport_number, b.seat_number,
               b.booking_date, b.status,
               f.flight_number, f.airline,
               f.origin, f.origin_code,
               f.destination, f.destination_code,
               f.departure_time, f.arrival_time,
               f.price, f.class
        FROM bookings b
        JOIN flights f ON b.flight_id = f.id
        WHERE b.user_id = $user_id
        ORDER BY b.booking_date DESC";

$result   = $conn->query($sql);
$bookings = [];

while ($row = $result->fetch_assoc()) {
    $bookings[] = $row;
}

sendResponse([
    "total"    => count($bookings),
    "bookings" => $bookings
]);

$conn->close();
?>
