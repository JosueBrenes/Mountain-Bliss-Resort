<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$habitacion_id = $_POST['habitacion_id'];
$descripcion = $_POST['descripcion'];
$fecha_mantenimiento = $_POST['fecha_mantenimiento'];
$costo = $_POST['costo'];

try {
    $fecha_mantenimiento_dt = new DateTime($fecha_mantenimiento);
    $fecha_mantenimiento_formateada = $fecha_mantenimiento_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

$query = 'SELECT Mantenimiento_SEQ.NEXTVAL AS id_mantenimiento FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_mantenimiento = $row['ID_MANTENIMIENTO'];

$sql = 'INSERT INTO Mantenimiento (MantenimientoID, HabitacionID, Descripcion, FechaMantenimiento, Costo) 
        VALUES (:id_mantenimiento, :habitacion_id, :descripcion, TO_DATE(:fecha_mantenimiento, \'YYYY-MM-DD\'), :costo)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_mantenimiento', $id_mantenimiento);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_bind_by_name($stid, ':descripcion', $descripcion);
oci_bind_by_name($stid, ':fecha_mantenimiento', $fecha_mantenimiento_formateada);
oci_bind_by_name($stid, ':costo', $costo);

$success = oci_execute($stid);

if ($success) {
    header('Location: mantenimiento.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar mantenimiento: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
