<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

// Must be authenticated
requireAuth();

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    sendError("Method not allowed. Use GET.", 405);
}

$conn = getConnection();

// Optional filters via query params
$where = [];
if (!empty($_GET['origin']))      $where[] = "origin_code = '" . $conn->real_escape_string($_GET['origin']) . "'";
if (!empty($_GET['destination'])) $where[] = "destination_code = '" . $conn->real_escape_string($_GET['destination']) . "'";
if (!empty($_GET['class']))       $where[] = "class = '" . $conn->real_escape_string($_GET['class']) . "'";
if (!empty($_GET['status']))      $where[] = "status = '" . $conn->real_escape_string($_GET['status']) . "'";

$sql = "SELECT * FROM flights";
if (!empty($where)) $sql .= " WHERE " . implode(" AND ", $where);
$sql .= " ORDER BY departure_time ASC";

$result = $conn->query($sql);
$flights = [];

while ($row = $result->fetch_assoc()) {
    $flights[] = $row;
}

sendResponse([
    "total"   => count($flights),
    "flights" => $flights
]);

$conn->close();
?>
