<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre_servicio = $_POST['nombre_servicio'];
$descripcion = $_POST['descripcion'];
$precio = $_POST['precio'];

// Validar los datos para evitar valores nulos
if (empty($nombre_servicio) || empty($descripcion) || empty($precio)) {
    echo "Todos los campos son obligatorios.";
    exit;
}

// Llamar al procedimiento almacenado para insertar servicio
$sql = 'BEGIN INSERTAR_SERVICIO(:nombre_servicio, :descripcion, :precio); END;';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':nombre_servicio', $nombre_servicio);
oci_bind_by_name($stid, ':descripcion', $descripcion);
oci_bind_by_name($stid, ':precio', $precio);

$success = oci_execute($stid);

if ($success) {
    header('Location: servicios.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar servicio: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
