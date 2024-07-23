<?php
$username = 'system';
$password = 'Filipenses4';
$connection_string = 'localhost/orcl'; 

$connection = oci_connect($username, $password, $connection_string);

if (!$connection) {
    $e = oci_error();
    echo "No se pudo conectar a la base de datos: " . $e['message'];
} else {
    echo "Conexión exitosa!";
}
?>
