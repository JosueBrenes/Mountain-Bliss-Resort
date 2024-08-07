<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $reserva_id = $_POST['reserva_id'];
    $huesped_id = $_POST['huesped_id'];
    $habitacion_id = $_POST['habitacion_id'];
    $fecha_entrada = $_POST['fecha_entrada'];
    $fecha_salida = $_POST['fecha_salida'];
    $estado = $_POST['estado'];

    if (empty($reserva_id) || empty($huesped_id) || empty($habitacion_id) || empty($fecha_entrada) || empty($fecha_salida) || empty($estado)) {
        die("Todos los campos son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ACTUALIZAR_RESERVA(:reserva_id, :huesped_id, :habitacion_id, TO_DATE(:fecha_entrada, \'YYYY-MM-DD\'), TO_DATE(:fecha_salida, \'YYYY-MM-DD\'), :estado); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':reserva_id', $reserva_id);
    oci_bind_by_name($stid, ':huesped_id', $huesped_id);
    oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
    oci_bind_by_name($stid, ':fecha_entrada', $fecha_entrada);
    oci_bind_by_name($stid, ':fecha_salida', $fecha_salida);
    oci_bind_by_name($stid, ':estado', $estado);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: reservas.php?msg=Reserva actualizada con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar la reserva: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
