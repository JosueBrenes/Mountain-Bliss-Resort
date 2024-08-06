<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$habitacion_id = $_POST['habitacion_id'];
$inventario_id = $_POST['inventario_id'];
$cantidad = $_POST['cantidad'];

$sql = 'INSERT INTO CantidadInventarioPorHabitacion (HabitacionID, InventarioID, Cantidad) 
        VALUES (:habitacion_id, :inventario_id, :cantidad)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_bind_by_name($stid, ':inventario_id', $inventario_id);
oci_bind_by_name($stid, ':cantidad', $cantidad);

$success = oci_execute($stid);

if ($success) {
    header('Location: cantidad_inventario_por_habitacion.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar cantidad de inventario por habitación: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
