<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $habitacion_id = $_POST['habitacion_id'];
    $inventario_id = $_POST['inventario_id'];
    $cantidad = $_POST['cantidad'];

    if (empty($habitacion_id) || empty($inventario_id) || empty($cantidad)) {
        die("Todos los campos son requeridos.");
    }

    $sql = 'UPDATE CantidadInventarioPorHabitacion SET Cantidad = :cantidad WHERE HabitacionID = :habitacion_id AND InventarioID = :inventario_id';
    $stid = oci_parse($conn, $sql);

    oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
    oci_bind_by_name($stid, ':inventario_id', $inventario_id);
    oci_bind_by_name($stid, ':cantidad', $cantidad);

    if (oci_execute($stid)) {
        header('Location: cantidad_inventario_por_habitacion.php?msg=Cantidad actualizada con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar la cantidad de inventario: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
