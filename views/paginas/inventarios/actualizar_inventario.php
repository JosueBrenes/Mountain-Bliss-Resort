<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $inventario_id = $_POST['inventario_id'];
    $nombre_producto = $_POST['nombre_producto'];
    $cantidad_total = $_POST['cantidad_total'];
    $unidad_medida = $_POST['unidad_medida'];

    if (empty($inventario_id) || empty($nombre_producto) || empty($cantidad_total) || empty($unidad_medida)) {
        die("Todos los campos son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ACTUALIZAR_INVENTARIO(:inventario_id, :nombre_producto, :cantidad_total, :unidad_medida); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':inventario_id', $inventario_id);
    oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
    oci_bind_by_name($stid, ':cantidad_total', $cantidad_total);
    oci_bind_by_name($stid, ':unidad_medida', $unidad_medida);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: inventarios.php?msg=Inventario actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el inventario: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
