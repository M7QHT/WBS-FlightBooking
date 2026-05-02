<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

$authUser = requireAuth();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError("Method not allowed. Use POST.", 405);
}

$data = json_decode(file_get_contents("php://input"), true);

if (empty($data['booking_id'])) {
    sendError("Field 'booking_id' is required.");
}

$conn       = getConnection();
$booking_id = (int) $data['booking_id'];
$user_id    = (int) $authUser['user_id'];

// Make sure the booking belongs to this user
$stmt = $conn->prepare("SELECT id, flight_id, status FROM bookings WHERE id = ? AND user_id = ? LIMIT 1");
$stmt->bind_param("ii", $booking_id, $user_id);
$stmt->execute();
$booking = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$booking) {
    sendError("Booking not found or access denied.", 404);
}

if ($booking['status'] === 'Cancelled') {
    sendError("Booking is already cancelled.", 400);
}

// Cancel the booking
$stmt2 = $conn->prepare("UPDATE bookings SET status = 'Cancelled' WHERE id = ?");
$stmt2->bind_param("i", $booking_id);
$stmt2->execute();
$stmt2->close();

// Restore the seat
$conn->query("UPDATE flights SET seats_available = seats_available + 1 WHERE id = " . (int)$booking['flight_id']);

sendResponse(["message" => "Booking cancelled successfully."]);

$conn->close();
?>
