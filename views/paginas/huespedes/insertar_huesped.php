<?php
include '../../../database/database.php';

// Verifica si la conexión se ha establecido correctamente
if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

// Recoge los parámetros del formulario
$nombre = $_POST['nombre'];
$apellido = $_POST['apellido'];
$fecha_nacimiento = $_POST['fecha_nacimiento'];
$direccion = $_POST['direccion'];
$telefono = $_POST['telefono'];
$email = $_POST['email'];

// Formatea la fecha de nacimiento
try {
    $fecha_nacimiento_dt = new DateTime($fecha_nacimiento);
    $fecha_nacimiento_formateada = $fecha_nacimiento_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

// Obtiene el siguiente valor de la secuencia para el ID del huésped
$query = 'SELECT Huesped_SEQ.NEXTVAL AS id_huesped FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_huesped = $row['ID_HUESPED'];

// Llama al procedimiento almacenado
$sql = 'BEGIN INSERTAR_HUESPED(:p_huespedid, :p_nombre, :p_apellido, TO_DATE(:p_fecha_nacimiento, \'YYYY-MM-DD\'), :p_direccion, :p_telefono, :p_email); END;';
$stid = oci_parse($conn, $sql);

// Asocia los parámetros del procedimiento
oci_bind_by_name($stid, ':p_huespedid', $id_huesped, -1, SQLT_INT);
oci_bind_by_name($stid, ':p_nombre', $nombre);
oci_bind_by_name($stid, ':p_apellido', $apellido);
oci_bind_by_name($stid, ':p_fecha_nacimiento', $fecha_nacimiento_formateada);
oci_bind_by_name($stid, ':p_direccion', $direccion);
oci_bind_by_name($stid, ':p_telefono', $telefono);
oci_bind_by_name($stid, ':p_email', $email);

// Ejecuta el procedimiento
$success = oci_execute($stid);

if ($success) {
    header('Location: huespedes.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar huésped: " . $e['message'];
}

// Libera los recursos
oci_free_statement($stid);
oci_close($conn);
?>
