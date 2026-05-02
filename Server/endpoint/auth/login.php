<?php
require_once '../../config/database.php';
require_once '../../helpers/response.php';
require_once '../../helpers/auth.php';

setCorsHeaders();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    sendError("Method not allowed. Use POST.", 405);
}

// القراءة الصحيحة للبيانات في بداية الملف
$data = json_decode(file_get_contents("php://input"), true) ?: $_POST;

if (empty($data['username']) || empty($data['password'])) {
    sendError("Username and password are required.");
}

$conn = getConnection();
$stmt = $conn->prepare("SELECT * FROM users WHERE username = ? LIMIT 1");
$stmt->bind_param("s", $data['username']);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    $stmt->close();
    $conn->close();
    sendError("Invalid username or password.", 401);
}

$user = $result->fetch_assoc();

if (!password_verify($data['password'], $user['password_hash'])) {
    $stmt->close();
    $conn->close();
    sendError("Invalid username or password.", 401);
}

$token = generateToken($user['id'], $user['username'], $user['role']);

sendResponse([
    "message"  => "Login successful",
    "token"    => $token,
    "user"     => [
        "id"       => $user['id'],
        "username" => $user['username'],
        "email"    => $user['email'],
        "role"     => $user['role']
    ]
]);

$stmt->close();
$conn->close();
?>
