<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $servicio_id = $_POST['servicio_id'];
    $nombre_servicio = $_POST['nombre_servicio'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];

    if (empty($servicio_id) || empty($nombre_servicio) || empty($precio)) {
        die("Todos los campos son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ACTUALIZAR_SERVICIO(:servicio_id, :nombre_servicio, :descripcion, :precio); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':servicio_id', $servicio_id);
    oci_bind_by_name($stid, ':nombre_servicio', $nombre_servicio);
    oci_bind_by_name($stid, ':descripcion', $descripcion);
    oci_bind_by_name($stid, ':precio', $precio);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: servicios.php?msg=Servicio actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el servicio: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
