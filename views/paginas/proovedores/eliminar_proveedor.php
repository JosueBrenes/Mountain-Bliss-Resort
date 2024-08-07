<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del proveedor no proporcionado.");
}

$proveedor_id = $_GET['id'];

// Verificar si el proveedor tiene registros dependientes en la tabla Facturacion
$check_sql = 'SELECT COUNT(*) AS count FROM Facturacion WHERE ProveedorID = :proveedor_id';
$check_stid = oci_parse($conn, $check_sql);
oci_bind_by_name($check_stid, ':proveedor_id', $proveedor_id);
oci_execute($check_stid);
$check_row = oci_fetch_assoc($check_stid);
$dependents = $check_row['COUNT'];

oci_free_statement($check_stid);

if ($dependents > 0) {
    die("No se puede eliminar el proveedor porque hay registros dependientes.");
}

// Iniciar una transacción
oci_execute(oci_parse($conn, 'BEGIN'));

// Preparar la llamada al procedimiento almacenado
$sql = 'BEGIN ELIMINAR_PROVEEDOR(:proveedor_id); END;';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':proveedor_id', $proveedor_id);

try {
    if (oci_execute($stid)) {
        // Confirmar la transacción
        oci_commit($conn);
        header('Location: proveedores.php?msg=Proveedor eliminado con éxito');
    } else {
        $error = oci_error($stid);
        throw new Exception("Error al eliminar el proveedor: " . htmlentities($error['message'], ENT_QUOTES));
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
