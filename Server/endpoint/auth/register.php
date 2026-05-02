<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError("Method not allowed. Use POST.", 405);
}

$data = json_decode(file_get_contents("php://input"), true) ?: $_POST;

// Validate required fields
if (empty($data['username']) || empty($data['email']) || empty($data['password'])) {
    sendError("Username, email, and password are required.");
}

if (strlen($data['password']) < 6) {
    sendError("Password must be at least 6 characters.");
}

if (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
    sendError("Invalid email format.");
}

$conn = getConnection();

// Check if username already exists
$stmt = $conn->prepare("SELECT id FROM users WHERE username = ? LIMIT 1");
$stmt->bind_param("s", $data['username']);
$stmt->execute();
$stmt->store_result();
if ($stmt->num_rows > 0) {
    $stmt->close();
    $conn->close();
    sendError("Username already taken. Please choose another.", 409);
}
$stmt->close();

// Check if email already exists
$stmt2 = $conn->prepare("SELECT id FROM users WHERE email = ? LIMIT 1");
$stmt2->bind_param("s", $data['email']);
$stmt2->execute();
$stmt2->store_result();
if ($stmt2->num_rows > 0) {
    $stmt2->close();
    $conn->close();
    sendError("Email already registered. Please login.", 409);
}
$stmt2->close();

// Hash password and insert user
$passwordHash = password_hash($data['password'], PASSWORD_BCRYPT);
$username     = $data['username'];
$email        = $data['email'];
$role         = 'user'; // default role

$stmt3 = $conn->prepare("INSERT INTO users (username, email, password_hash, role) VALUES (?, ?, ?, ?)");
$stmt3->bind_param("ssss", $username, $email, $passwordHash, $role);

if (!$stmt3->execute()) {
    $stmt3->close();
    $conn->close();
    sendError("Registration failed: " . $conn->error, 500);
}

$newUserId = $conn->insert_id;
$stmt3->close();

// Auto-login: generate token
$token = generateToken($newUserId, $username, $role);

sendResponse([
    "message" => "Account created successfully!",
    "token"   => $token,
    "user"    => [
        "id"       => $newUserId,
        "username" => $username,
        "email"    => $email,
        "role"     => $role
    ]
], 201);

$conn->close();
?>
