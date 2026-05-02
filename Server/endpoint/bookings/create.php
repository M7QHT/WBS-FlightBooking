<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

// Must be authenticated
$authUser = requireAuth();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError("Method not allowed. Use POST.", 405);
}

$data = json_decode(file_get_contents("php://input"), true);

// Validate required fields
$required = ['flight_id', 'passenger_name', 'passport_number'];
foreach ($required as $field) {
    if (empty($data[$field])) {
        sendError("Field '$field' is required.");
    }
}

$conn          = getConnection();
$flight_id     = (int) $data['flight_id'];
$passenger     = $conn->real_escape_string($data['passenger_name']);
$passport      = $conn->real_escape_string($data['passport_number']);
$seat          = $conn->real_escape_string($data['seat_number'] ?? '');
$user_id       = $authUser['user_id'];

// Check flight exists and has seats
$flight = $conn->query("SELECT * FROM flights WHERE id = $flight_id LIMIT 1")->fetch_assoc();
if (!$flight) {
    sendError("Flight not found.", 404);
}
if ($flight['seats_available'] <= 0) {
    sendError("No seats available for this flight.", 400);
}

// Insert booking
$sql = "INSERT INTO bookings (user_id, flight_id, passenger_name, passport_number, seat_number)
        VALUES ($user_id, $flight_id, '$passenger', '$passport', '$seat')";

if (!$conn->query($sql)) {
    sendError("Booking failed: " . $conn->error, 500);
}

$bookingId = $conn->insert_id;

// Decrease seats
$conn->query("UPDATE flights SET seats_available = seats_available - 1 WHERE id = $flight_id");

sendResponse([
    "message"    => "Booking confirmed successfully!",
    "booking_id" => $bookingId,
    "details"    => [
        "passenger"     => $passenger,
        "flight_number" => $flight['flight_number'],
        "from"          => $flight['origin'] . " (" . $flight['origin_code'] . ")",
        "to"            => $flight['destination'] . " (" . $flight['destination_code'] . ")",
        "departure"     => $flight['departure_time'],
        "price"         => $flight['price'],
        "seat"          => $seat ?: "To be assigned"
    ]
], 201);

$conn->close();
?>
