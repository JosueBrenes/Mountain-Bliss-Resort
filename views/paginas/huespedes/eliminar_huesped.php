<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id'])) {
    $huespedId = $_GET['id'];

    // Iniciar transacción
    $begin = oci_parse($conn, 'BEGIN');
    oci_execute($begin);
    
    // Primero, eliminar registros en la tabla Reservas
    $deleteReservasSql = 'DELETE FROM Reservas WHERE HuespedID = :huesped_id';
    $deleteReservasStid = oci_parse($conn, $deleteReservasSql);
    oci_bind_by_name($deleteReservasStid, ':huesped_id', $huespedId);
    
    $resultReservas = oci_execute($deleteReservasStid);

    if ($resultReservas) {
        // Eliminar el huésped
        $deleteHuespedesSql = 'BEGIN ELIMINAR_HUESPED(:huesped_id); END;';
        $deleteHuespedesStid = oci_parse($conn, $deleteHuespedesSql);
        oci_bind_by_name($deleteHuespedesStid, ':huesped_id', $huespedId);
        
        $resultHuespedes = oci_execute($deleteHuespedesStid);

        if ($resultHuespedes) {
            $commit = oci_parse($conn, 'COMMIT');
            oci_execute($commit);
            echo "<script>alert('Huésped eliminado con éxito.'); window.location.href='huespedes.php';</script>";
        } else {
            $rollback = oci_parse($conn, 'ROLLBACK');
            oci_execute($rollback);
            $e = oci_error($deleteHuespedesStid);
            echo "<script>alert('Error al eliminar el huésped: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='huespedes.php';</script>";
        }
    } else {
        $rollback = oci_parse($conn, 'ROLLBACK');
        oci_execute($rollback);
        $e = oci_error($deleteReservasStid);
        echo "<script>alert('Error al eliminar registros de reservas: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='huespedes.php';</script>";
    }

    oci_free_statement($deleteReservasStid);
    oci_free_statement($deleteHuespedesStid);
} else {
    echo "<script>alert('ID de huésped no especificado.'); window.location.href='huespedes.php';</script>";
}

oci_close($conn);
?>
