<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre_producto = $_POST['nombre_producto'];
$cantidad_total = $_POST['cantidad_total'];
$unidad_medida = $_POST['unidad_medida'];

// Validar los datos para evitar valores nulos
if (empty($nombre_producto) || empty($cantidad_total) || empty($unidad_medida)) {
    echo "Todos los campos son obligatorios.";
    exit;
}

// Obtener el siguiente valor de la secuencia
$query = 'SELECT Inventario_SEQ.NEXTVAL AS inventario_id FROM dual';
$stid_seq = oci_parse($conn, $query);
oci_execute($stid_seq);
$row = oci_fetch_assoc($stid_seq);
$id_inventario = $row['INVENTARIO_ID'];

oci_free_statement($stid_seq);

// Llamar al procedimiento almacenado para insertar el inventario
$sql = 'BEGIN INSERTAR_INVENTARIO(:inventario_id, :nombre_producto, :cantidad_total, :unidad_medida); END;';
$stid = oci_parse($conn, $sql);

// Vincular los parámetros
oci_bind_by_name($stid, ':inventario_id', $id_inventario);
oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
oci_bind_by_name($stid, ':cantidad_total', $cantidad_total);
oci_bind_by_name($stid, ':unidad_medida', $unidad_medida);

$success = oci_execute($stid);

if ($success) {
    header('Location: inventarios.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar inventario: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
