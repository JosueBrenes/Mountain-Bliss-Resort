<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del mantenimiento no proporcionado.");
}

$mantenimiento_id = $_GET['id'];

// Iniciar una transacción
oci_execute(oci_parse($conn, 'BEGIN'));

// Preparar la llamada al procedimiento almacenado
$sql = 'BEGIN ELIMINAR_MANTENIMIENTO(:mantenimiento_id); END;';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':mantenimiento_id', $mantenimiento_id);

try {
    if (oci_execute($stid)) {
        // Confirmar la transacción
        oci_commit($conn);
        header('Location: mantenimiento.php?msg=Mantenimiento eliminado con éxito');
    } else {
        $error = oci_error($stid);
        throw new Exception("Error al eliminar el mantenimiento: " . htmlentities($error['message'], ENT_QUOTES));
    }
} catch (Exception $e) {
    // Revertir la transacción en caso de error
    oci_rollback($conn);
    die($e->getMessage());
} finally {
    oci_free_statement($stid);
    oci_close($conn);
}
?>
