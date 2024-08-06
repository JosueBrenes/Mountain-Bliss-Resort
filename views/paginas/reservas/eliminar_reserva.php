<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id'])) {
    $reservaId = $_GET['id'];

    $deleteFacturacionSql = 'DELETE FROM Facturacion WHERE ReservaID = :reserva_id';
    $deleteFacturacionStid = oci_parse($conn, $deleteFacturacionSql);
    oci_bind_by_name($deleteFacturacionStid, ':reserva_id', $reservaId);
    oci_execute($deleteFacturacionStid);
    oci_free_statement($deleteFacturacionStid);

    $deleteSql = 'DELETE FROM Reservas WHERE ReservaID = :reserva_id';
    $deleteStid = oci_parse($conn, $deleteSql);
    oci_bind_by_name($deleteStid, ':reserva_id', $reservaId);
    
    if (oci_execute($deleteStid)) {
        echo "<script>alert('Reserva eliminada con éxito.'); window.location.href='reservas.php';</script>";
    } else {
        $e = oci_error($deleteStid);
        echo "<script>alert('Error al eliminar la reserva: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='reservas.php';</script>";
    }

    oci_free_statement($deleteStid);
} else {
    echo "<script>alert('ID de reserva no especificado.'); window.location.href='reservas.php';</script>";
}

oci_close($conn);
?>
