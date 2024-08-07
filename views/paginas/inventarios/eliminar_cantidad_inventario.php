<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['habitacion_id']) && isset($_GET['inventario_id'])) {
    $habitacionId = $_GET['habitacion_id'];
    $inventarioId = $_GET['inventario_id'];

    // Iniciar una transacción
    $begin = oci_parse($conn, 'BEGIN');
    oci_execute($begin);

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ELIMINAR_CANTIDAD_INVENTARIO_POR_HABITACION(:habitacion_id, :inventario_id); END;';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':habitacion_id', $habitacionId);
    oci_bind_by_name($stid, ':inventario_id', $inventarioId);
    
    if (oci_execute($stid)) {
        // Confirmar la transacción
        $commit = oci_parse($conn, 'COMMIT');
        oci_execute($commit);
        echo "<script>alert('Cantidad de inventario eliminada con éxito.'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
    } else {
        // Revertir la transacción en caso de error
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $e = oci_error($stid);
        echo "<script>alert('Error al eliminar la cantidad de inventario: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
    }

    oci_free_statement($stid);
} else {
    echo "<script>alert('ID de habitación o inventario no especificado.'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
}

oci_close($conn);
?>
