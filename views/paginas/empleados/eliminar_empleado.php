<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del empleado no proporcionado.");
}

$empleado_id = $_GET['id'];

$sql = 'DELETE FROM Empleados WHERE EmpleadoID = :empleado_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':empleado_id', $empleado_id);

if (oci_execute($stid)) {
    header('Location: empleados.php?msg=Empleado eliminado con éxito');
} else {
    $error = oci_error($stid);
    die("Error al eliminar el empleado: " . htmlentities($error['message'], ENT_QUOTES));
}

oci_free_statement($stid);
oci_close($conn);
?>
