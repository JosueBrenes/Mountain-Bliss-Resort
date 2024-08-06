<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del servicio no proporcionado.");
}

$servicio_id = $_GET['id'];

$sql = 'DELETE FROM Servicios WHERE ServicioID = :servicio_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':servicio_id', $servicio_id);

if (oci_execute($stid)) {
    header('Location: servicios.php?msg=Servicio eliminado con éxito');
} else {
    $error = oci_error($stid);
    die("Error al eliminar el servicio: " . htmlentities($error['message'], ENT_QUOTES));
}

oci_free_statement($stid);
oci_close($conn);
?>
