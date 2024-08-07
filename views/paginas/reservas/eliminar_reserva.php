<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id'])) {
    $reservaId = $_GET['id'];

    // Iniciar transacción
    $begin = oci_parse($conn, 'BEGIN');
    oci_execute($begin);
    
    // Llamar al procedimiento almacenado para eliminar la reserva
    $deleteReservaSql = 'BEGIN ELIMINAR_RESERVA(:reserva_id); END;';
    $deleteReservaStid = oci_parse($conn, $deleteReservaSql);
    oci_bind_by_name($deleteReservaStid, ':reserva_id', $reservaId);
    
    $resultReserva = oci_execute($deleteReservaStid);

    if ($resultReserva) {
        // Commit si la reserva se elimina exitosamente
        $commit = oci_parse($conn, 'COMMIT');
        oci_execute($commit);
        echo "<script>alert('Reserva eliminada con éxito.'); window.location.href='reservas.php';</script>";
    } else {
        // Rollback en caso de error
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $e = oci_error($deleteReservaStid);
        echo "<script>alert('Error al eliminar la reserva: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='reservas.php';</script>";
    }

    oci_free_statement($deleteReservaStid);
} else {
    echo "<script>alert('ID de reserva no especificado.'); window.location.href='reservas.php';</script>";
}

oci_close($conn);
?>
