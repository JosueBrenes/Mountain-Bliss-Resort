<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del proveedor no proporcionado.");
}

$proveedor_id = $_GET['id'];

$check_sql = 'SELECT COUNT(*) AS count FROM Facturacion WHERE ProveedorID = :proveedor_id';
$check_stid = oci_parse($conn, $check_sql);
oci_bind_by_name($check_stid, ':proveedor_id', $proveedor_id);
oci_execute($check_stid);
$check_row = oci_fetch_assoc($check_stid);
$dependents = $check_row['COUNT'];

if ($dependents > 0) {
    die("No se puede eliminar el proveedor porque hay registros dependientes.");
}

// Eliminar proveedor
$sql = 'DELETE FROM Proveedores WHERE ProveedorID = :proveedor_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':proveedor_id', $proveedor_id);

if (oci_execute($stid)) {
    header('Location: proveedores.php?msg=Proveedor eliminado con éxito');
} else {
    $error = oci_error($stid);
    die("Error al eliminar el proveedor: " . htmlentities($error['message'], ENT_QUOTES));
}

oci_free_statement($stid);
oci_close($conn);
?>
