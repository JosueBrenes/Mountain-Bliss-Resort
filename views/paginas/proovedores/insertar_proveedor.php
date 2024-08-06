<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre_proveedor = $_POST['nombre_proveedor'];
$direccion = $_POST['direccion'];
$telefono = $_POST['telefono'];
$email = $_POST['email'];

$query = 'SELECT Proveedor_SEQ.NEXTVAL AS id_proveedor FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_proveedor = $row['ID_PROVEEDOR'];

$sql = 'INSERT INTO Proveedores (ProveedorID, NombreProveedor, Direccion, Telefono, Email) 
        VALUES (:id_proveedor, :nombre_proveedor, :direccion, :telefono, :email)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_proveedor', $id_proveedor);
oci_bind_by_name($stid, ':nombre_proveedor', $nombre_proveedor);
oci_bind_by_name($stid, ':direccion', $direccion);
oci_bind_by_name($stid, ':telefono', $telefono);
oci_bind_by_name($stid, ':email', $email);

$success = oci_execute($stid);

if ($success) {
    header('Location: proveedores.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar proveedor: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
