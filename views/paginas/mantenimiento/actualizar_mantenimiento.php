<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $mantenimiento_id = $_POST['mantenimiento_id'];
    $habitacion_id = $_POST['habitacion_id'];
    $fecha_mantenimiento = $_POST['fecha_mantenimiento'];
    $descripcion = $_POST['descripcion'];
    $costo = $_POST['costo'];

    if (empty($mantenimiento_id) || empty($habitacion_id) || empty($fecha_mantenimiento) || empty($descripcion) || empty($costo)) {
        die("Todos los campos son requeridos.");
    }

    $sql = 'UPDATE Mantenimiento SET HabitacionID = :habitacion_id, FechaMantenimiento = TO_DATE(:fecha_mantenimiento, \'YYYY-MM-DD\'), Descripcion = :descripcion, Costo = :costo WHERE MantenimientoID = :mantenimiento_id';
    $stid = oci_parse($conn, $sql);

    oci_bind_by_name($stid, ':mantenimiento_id', $mantenimiento_id);
    oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
    oci_bind_by_name($stid, ':fecha_mantenimiento', $fecha_mantenimiento);
    oci_bind_by_name($stid, ':descripcion', $descripcion);
    oci_bind_by_name($stid, ':costo', $costo);

    if (oci_execute($stid)) {
        header('Location: mantenimiento.php?msg=Mantenimiento actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el mantenimiento: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
