<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID de la factura no proporcionado.");
}

$factura_id = $_GET['id'];

$sql = 'DELETE FROM Facturacion WHERE FacturaID = :factura_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':factura_id', $factura_id);

if (oci_execute($stid)) {
    header('Location: facturacion.php?msg=Factura eliminada con éxito');
} else {
    $error = oci_error($stid);
    die("Error al eliminar la factura: " . htmlentities($error['message'], ENT_QUOTES));
}

oci_free_statement($stid);
oci_close($conn);
?>
