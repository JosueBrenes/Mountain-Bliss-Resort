<?php
// Datos de conexión
$username = 'LB_User';
$password = 'LB_User';
$dbname = 'Mountain-Bliss-Resortt'; 
$hostname = 'localhost:1521/orcl';

// Establecer la conexión
$conn = oci_connect($username, $password, $hostname);

if (!$conn) {
    $e = oci_error();
    echo htmlentities($e['message'], ENT_QUOTES);
    exit;
}
?>