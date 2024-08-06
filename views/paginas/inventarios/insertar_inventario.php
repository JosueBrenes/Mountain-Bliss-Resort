<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre_producto = $_POST['nombre_producto'];
$cantidad = $_POST['cantidad'];
$ubicacion = $_POST['ubicacion'];

$query = 'SELECT Inventario_SEQ.NEXTVAL AS id_inventario FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_inventario = $row['ID_INVENTARIO'];

$sql = 'INSERT INTO Inventarios (InventarioID, NombreProducto, Cantidad, Ubicacion) 
        VALUES (:id_inventario, :nombre_producto, :cantidad, :ubicacion)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_inventario', $id_inventario);
oci_bind_by_name($stid, ':nombre_producto', $nombre_producto);
oci_bind_by_name($stid, ':cantidad', $cantidad);
oci_bind_by_name($stid, ':ubicacion', $ubicacion);

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
