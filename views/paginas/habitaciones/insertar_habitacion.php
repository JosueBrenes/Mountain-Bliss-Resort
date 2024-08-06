<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$numero_habitacion = $_POST['numero_habitacion'];
$tipo_habitacion = $_POST['tipo_habitacion'];
$precio_por_noche = $_POST['precio_por_noche'];
$estado = $_POST['estado'];

$query = 'SELECT Habitacion_SEQ.NEXTVAL AS id_habitacion FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_habitacion = $row['ID_HABITACION'];

$sql = 'INSERT INTO Habitaciones (HabitacionID, NumeroHabitacion, TipoHabitacion, PrecioPorNoche, Estado) 
        VALUES (:id_habitacion, :numero_habitacion, :tipo_habitacion, :precio_por_noche, :estado)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_habitacion', $id_habitacion);
oci_bind_by_name($stid, ':numero_habitacion', $numero_habitacion);
oci_bind_by_name($stid, ':tipo_habitacion', $tipo_habitacion);
oci_bind_by_name($stid, ':precio_por_noche', $precio_por_noche);
oci_bind_by_name($stid, ':estado', $estado);

$success = oci_execute($stid);

if ($success) {
    header('Location: habitaciones.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar habitación: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
