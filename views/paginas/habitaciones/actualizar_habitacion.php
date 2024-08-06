<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $habitacion_id = $_POST['habitacion_id'];
    $numero_habitacion = $_POST['numero_habitacion'];
    $tipo_habitacion = $_POST['tipo_habitacion'];
    $precio_por_noche = $_POST['precio_por_noche'];
    $estado = $_POST['estado'];

    if (empty($habitacion_id) || empty($numero_habitacion) || empty($tipo_habitacion) || empty($precio_por_noche) || empty($estado)) {
        die("Todos los campos son requeridos.");
    }

    $sql = 'UPDATE Habitaciones SET NumeroHabitacion = :numero_habitacion, TipoHabitacion = :tipo_habitacion, PrecioPorNoche = :precio_por_noche, Estado = :estado WHERE HabitacionID = :habitacion_id';
    $stid = oci_parse($conn, $sql);

    oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
    oci_bind_by_name($stid, ':numero_habitacion', $numero_habitacion);
    oci_bind_by_name($stid, ':tipo_habitacion', $tipo_habitacion);
    oci_bind_by_name($stid, ':precio_por_noche', $precio_por_noche);
    oci_bind_by_name($stid, ':estado', $estado);

    if (oci_execute($stid)) {
        header('Location: habitaciones.php?msg=Habitación actualizada con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar la habitación: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
?>
