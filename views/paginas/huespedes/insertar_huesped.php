<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$fecha_nacimiento = $_POST['fecha_nacimiento'];
$direccion = $_POST['direccion'];
$telefono = $_POST['telefono'];
$email = $_POST['email'];

try {
    $fecha_nacimiento_dt = new DateTime($fecha_nacimiento);
    $fecha_nacimiento_formateada = $fecha_nacimiento_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

$query = 'SELECT Huesped_SEQ.NEXTVAL AS id_huesped FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_huesped = $row['ID_HUESPED'];

$sql = 'INSERT INTO Huespedes (HuespedID, Nombre, Apellido, FechaNacimiento, Direccion, Telefono, Email) 
        VALUES (:id_huesped, :nombre, :apellido, TO_DATE(:fecha_nacimiento, \'YYYY-MM-DD\'), :direccion, :telefono, :email)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_huesped', $id_huesped);
oci_bind_by_name($stid, ':nombre', $nombre);
oci_bind_by_name($stid, ':apellido', $apellido);
oci_bind_by_name($stid, ':fecha_nacimiento', $fecha_nacimiento_formateada);
oci_bind_by_name($stid, ':direccion', $direccion);
oci_bind_by_name($stid, ':telefono', $telefono);
oci_bind_by_name($stid, ':email', $email);

$success = oci_execute($stid);

if ($success) {
    header('Location: huespedes.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar huésped: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
