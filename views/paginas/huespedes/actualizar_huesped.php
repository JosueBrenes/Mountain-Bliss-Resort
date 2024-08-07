<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $huesped_id = $_POST['huesped_id'];
    $nombre = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $fecha_nacimiento = $_POST['fecha_nacimiento'];
    $direccion = $_POST['direccion'];
    $telefono = $_POST['telefono'];
    $email = $_POST['email'];

    if (empty($huesped_id) || empty($nombre) || empty($apellido)) {
        die("Los campos Nombre y Apellido son requeridos.");
    }

    // Preparar la llamada al procedimiento almacenado
    $sql = 'BEGIN ACTUALIZAR_HUESPED(:huesped_id, :nombre, :apellido, TO_DATE(:fecha_nacimiento, \'YYYY-MM-DD\'), :direccion, :telefono, :email); END;';
    $stid = oci_parse($conn, $sql);

    // Enlazar los parámetros
    oci_bind_by_name($stid, ':huesped_id', $huesped_id);
    oci_bind_by_name($stid, ':nombre', $nombre);
    oci_bind_by_name($stid, ':apellido', $apellido);
    oci_bind_by_name($stid, ':fecha_nacimiento', $fecha_nacimiento);
    oci_bind_by_name($stid, ':direccion', $direccion);
    oci_bind_by_name($stid, ':telefono', $telefono);
    oci_bind_by_name($stid, ':email', $email);

    // Ejecutar la llamada al procedimiento almacenado
    if (oci_execute($stid)) {
        header('Location: huespedes.php?msg=Huésped actualizado con éxito');
    } else {
        $error = oci_error($stid);
        die("Error al actualizar el huésped: " . htmlentities($error['message'], ENT_QUOTES));
    }

    oci_free_statement($stid);
    oci_close($conn);
} else {
    die("Método de solicitud no válido.");
}
