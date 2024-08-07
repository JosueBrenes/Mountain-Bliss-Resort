<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id']) && !empty($_GET['id'])) {
    $habitacion_id = $_GET['id'];

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ELIMINAR_HABITACION(:habitacion_id); END;';
    $stid = oci_parse($conn, $sql);
    oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);

    // Ejecutar el procedimiento almacenado
    if (oci_execute($stid)) {
        // Confirmar los cambios en la base de datos
        $commit = oci_parse($conn, 'COMMIT');
        oci_execute($commit);
        echo "<script>alert('Habitación eliminada con éxito.'); window.location.href='habitaciones.php';</script>";
    } else {
        // Deshacer los cambios en caso de error
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $error = oci_error($stid);
        echo "<script>alert('Error al eliminar la habitación: " . htmlentities($error['message'], ENT_QUOTES) . "'); window.location.href='habitaciones.php';</script>";
    }

    oci_free_statement($stid);
} else {
    echo "<script>alert('ID de la habitación no especificado.'); window.location.href='habitaciones.php';</script>";
}

oci_close($conn);
?>
