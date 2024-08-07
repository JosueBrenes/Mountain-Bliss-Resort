<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id'])) {
    $servicioId = $_GET['id'];

    // Iniciar transacción
    $begin = oci_parse($conn, 'BEGIN');
    oci_execute($begin);
    
    // Llamar al procedimiento almacenado para eliminar el servicio
    $deleteServicioSql = 'BEGIN ELIMINAR_SERVICIO(:servicio_id); END;';
    $deleteServicioStid = oci_parse($conn, $deleteServicioSql);
    oci_bind_by_name($deleteServicioStid, ':servicio_id', $servicioId);
    
    $resultServicio = oci_execute($deleteServicioStid);

    if ($resultServicio) {
        $commit = oci_parse($conn, 'COMMIT');
        oci_execute($commit);
        echo "<script>alert('Servicio eliminado con éxito.'); window.location.href='servicios.php';</script>";
    } else {
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $e = oci_error($deleteServicioStid);
        echo "<script>alert('Error al eliminar el servicio: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='servicios.php';</script>";
    }

    oci_free_statement($deleteServicioStid);
} else {
    echo "<script>alert('ID del servicio no especificado.'); window.location.href='servicios.php';</script>";
}

oci_close($conn);
?>
