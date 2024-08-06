<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$huesped_id = $_POST['huesped_id'];
$habitacion_id = $_POST['habitacion_id'];
$fecha_entrada = $_POST['fecha_entrada'];
$fecha_salida = $_POST['fecha_salida'];
$estado = $_POST['estado'];

try {
    $fecha_entrada_dt = new DateTime($fecha_entrada);
    $fecha_entrada_formateada = $fecha_entrada_dt->format('Y-m-d');

    $fecha_salida_dt = new DateTime($fecha_salida);
    $fecha_salida_formateada = $fecha_salida_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

$query = 'SELECT Reserva_SEQ.NEXTVAL AS id_reserva FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_reserva = $row['ID_RESERVA'];

$sql = 'INSERT INTO Reservas (ReservaID, HuespedID, HabitacionID, FechaEntrada, FechaSalida, Estado) 
        VALUES (:id_reserva, :huesped_id, :habitacion_id, TO_DATE(:fecha_entrada, \'YYYY-MM-DD\'), TO_DATE(:fecha_salida, \'YYYY-MM-DD\'), :estado)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_reserva', $id_reserva);
oci_bind_by_name($stid, ':huesped_id', $huesped_id);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_bind_by_name($stid, ':fecha_entrada', $fecha_entrada_formateada);
oci_bind_by_name($stid, ':fecha_salida', $fecha_salida_formateada);
oci_bind_by_name($stid, ':estado', $estado);

$success = oci_execute($stid);

if ($success) {
    header('Location: reservas.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar reserva: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
