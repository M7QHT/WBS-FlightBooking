<?php
define('JWT_SECRET', 'flightbook_secret_key_2025');

function base64url_encode($data) {
    return rtrim(strtr(base64_encode($data), '+/', '-_'), '=');
}

function base64url_decode($data) {
    return base64_decode(strtr($data, '-_', '+/') . str_repeat('=', 3 - (3 + strlen($data)) % 4));
}

function generateToken($userId, $username, $role) {
    $header = json_encode(['typ' => 'JWT', 'alg' => 'HS256']);
    $payload = json_encode([
        'user_id'  => $userId,
        'username' => $username,
        'role'     => $role,
        'exp'      => time() + 3600  // expires in 1 hour
    ]);
    $base = base64url_encode($header) . '.' . base64url_encode($payload);
    $sig  = hash_hmac('sha256', $base, JWT_SECRET, true);
    return $base . '.' . base64url_encode($sig);
}

function validateToken($token) {
    $parts = explode('.', $token);
    if (count($parts) !== 3) return false;

    $base = $parts[0] . '.' . $parts[1];
    $sig  = base64url_encode(hash_hmac('sha256', $base, JWT_SECRET, true));
    if ($sig !== $parts[2]) return false;

    $payload = json_decode(base64url_decode($parts[1]), true);
    if ($payload['exp'] < time()) return false;

    return $payload;
}

function requireAuth() {
    $headers = getallheaders();
    $auth    = $headers['Authorization'] ?? $headers['authorization'] ?? '';

    if (!preg_match('/Bearer\s(\S+)/', $auth, $matches)) {
        http_response_code(401);
        echo json_encode(["error" => "Unauthorized. Token missing."]);
        exit();
    }

    $payload = validateToken($matches[1]);
    if (!$payload) {
        http_response_code(401);
        echo json_encode(["error" => "Unauthorized. Invalid or expired token."]);
        exit();
    }

    return $payload;
}
?>
