<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id']) && !empty($_GET['id'])) {
    $inventario_id = $_GET['id'];

    // Iniciar una transacción
    $begin = oci_parse($conn, 'BEGIN');
    oci_execute($begin);

    // Preparar y ejecutar la llamada al procedimiento almacenado
    $sql = 'BEGIN ELIMINAR_INVENTARIO(:inventario_id); END;';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':inventario_id', $inventario_id);

    if (oci_execute($stid)) {
        // Confirmar la transacción
        $commit = oci_parse($conn, 'COMMIT');
        oci_execute($commit);
        echo "<script>alert('Inventario eliminado con éxito.'); window.location.href='inventarios.php';</script>";
    } else {
        // Revertir la transacción en caso de error
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $error = oci_error($stid);
        echo "<script>alert('Error al eliminar el inventario: " . htmlentities($error['message'], ENT_QUOTES) . "'); window.location.href='inventarios.php';</script>";
    }

    oci_free_statement($stid);
} else {
    echo "<script>alert('ID de inventario no especificado.'); window.location.href='inventarios.php';</script>";
}

oci_close($conn);
?>
