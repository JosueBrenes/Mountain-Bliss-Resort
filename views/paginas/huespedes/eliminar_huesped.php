<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del huésped no proporcionado.");
}

$huesped_id = $_GET['id'];
$sql = 'DELETE FROM Huespedes WHERE HuespedID = :huesped_id';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':huesped_id', $huesped_id);

$success = oci_execute($stid);

if ($success) {
    header('Location: huespedes.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al eliminar huésped: " . htmlentities($e['message'], ENT_QUOTES);
}

oci_free_statement($stid);
oci_close($conn);
?>
