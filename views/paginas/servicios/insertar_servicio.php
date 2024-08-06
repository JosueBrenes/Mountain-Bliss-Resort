<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre_servicio = $_POST['nombre_servicio'];
$descripcion = $_POST['descripcion'];
$precio = $_POST['precio'];

$query = 'SELECT Servicio_SEQ.NEXTVAL AS id_servicio FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_servicio = $row['ID_SERVICIO'];

$sql = 'INSERT INTO Servicios (ServicioID, NombreServicio, Descripcion, Precio) 
        VALUES (:id_servicio, :nombre_servicio, :descripcion, :precio)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_servicio', $id_servicio);
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
