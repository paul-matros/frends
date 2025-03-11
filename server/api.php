<?php
/**
 * api.php - Simple REST service stub that returns car data
 *
 * This file acts as a simple REST API endpoint that returns
 * a JSON response with information about a user named John
 * and his cars.
 */

// Set the content type to JSON
header('Content-Type: application/json');

// Allow cross-origin requests (CORS) - useful for local development
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// If this is a preflight OPTIONS request, return early
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Only respond to GET requests
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Create our response data structure
    $data = [
        "name" => "John",
        "cars" => [
            [
                "name" => "Ford",
                "model" => "Mustang"
            ],
            [
                "name" => "BMW",
                "model" => "X5"
            ]
        ]
    ];

    // Return the JSON response
    echo json_encode($data);
} else {
    // If not a GET request, return a 405 Method Not Allowed error
    http_response_code(405);
    echo json_encode(["error" => "Method not allowed"]);
}
?>