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

$conn = getConnection();
$user_id = $authUser['user_id'];

if (empty($data['flight_id']) || empty($data['passengers']) || !is_array($data['passengers'])) {
    sendError("flight_id and an array of passengers are required.", 400);
}

$flight_id = (int) $data['flight_id'];
$pnr = isset($data['pnr']) ? $conn->real_escape_string($data['pnr']) : ('PNR-' . strtoupper(substr(md5(uniqid()), 0, 6)));

// Check flight
$flight = $conn->query("SELECT * FROM flights WHERE id = $flight_id LIMIT 1")->fetch_assoc();
if (!$flight) {
    sendError("Flight not found.", 404);
}

$passengersCount = count($data['passengers']);
if ($flight['seats_available'] < $passengersCount) {
    sendError("Not enough seats available. Only " . $flight['seats_available'] . " left.", 400);
}

// Insert each passenger
foreach ($data['passengers'] as $p) {
    $passengerName = $conn->real_escape_string($p['name']);
    $passport = $conn->real_escape_string($p['passport']);
    $seat = $conn->real_escape_string($p['seat'] ?? '');
    $baggage = $conn->real_escape_string($p['baggage'] ?? '20KG (Included)');
    $price_paid = (float)($p['price_paid'] ?? $flight['price']);

    if (empty($passengerName) || empty($passport)) {
        sendError("Each passenger must have a name and passport number.", 400);
    }

    $sql = "INSERT INTO bookings (user_id, flight_id, pnr, passenger_name, passport_number, seat_number, baggage, price_paid)
            VALUES ($user_id, $flight_id, '$pnr', '$passengerName', '$passport', '$seat', '$baggage', $price_paid)";

    if (!$conn->query($sql)) {
        sendError("Booking failed: " . $conn->error, 500);
    }
}

// Decrease seats
$conn->query("UPDATE flights SET seats_available = seats_available - $passengersCount WHERE id = $flight_id");

sendResponse([
    "message"    => "Booking confirmed successfully!",
    "pnr"        => $pnr,
    "details"    => [
        "passengers_count" => $passengersCount,
        "flight_number"    => $flight['flight_number'],
        "from"             => $flight['origin'] . " (" . $flight['origin_code'] . ")",
        "to"               => $flight['destination'] . " (" . $flight['destination_code'] . ")"
    ]
], 201);

$conn->close();
?>
