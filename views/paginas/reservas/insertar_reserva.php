<?php
include '../../../database/database.php';

if (!$conn) {
    die("No se pudo conectar a la base de datos.");
}

// Obtener los datos del formulario
$huesped_id = $_POST['huesped_id'];
$habitacion_id = $_POST['habitacion_id'];
$fecha_entrada = $_POST['fecha_entrada'];
$fecha_salida = $_POST['fecha_salida'];
$estado = $_POST['estado'];

try {
    // Convertir las fechas a formato adecuado
    $fecha_entrada_dt = new DateTime($fecha_entrada);
    $fecha_entrada_formateada = $fecha_entrada_dt->format('d-M-Y'); // Formato esperado por Oracle

    $fecha_salida_dt = new DateTime($fecha_salida);
    $fecha_salida_formateada = $fecha_salida_dt->format('d-M-Y'); // Formato esperado por Oracle
} catch (Exception $e) {
    die("Error al formatear la fecha: " . $e->getMessage());
}

// Obtener el siguiente valor de la secuencia para ReservaID
$query = 'SELECT Reserva_SEQ.NEXTVAL AS id_reserva FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_reserva = $row['ID_RESERVA'];
oci_free_statement($stid);

// Preparar la llamada al procedimiento almacenado
$sql = 'BEGIN INSERTAR_RESERVA(:id_reserva, :huesped_id, :habitacion_id, TO_DATE(:fecha_entrada, \'DD-MON-YYYY\'), TO_DATE(:fecha_salida, \'DD-MON-YYYY\'), :estado); END;';
$stid = oci_parse($conn, $sql);

// Asociar los parámetros
oci_bind_by_name($stid, ':id_reserva', $id_reserva);
oci_bind_by_name($stid, ':huesped_id', $huesped_id);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_bind_by_name($stid, ':fecha_entrada', $fecha_entrada_formateada);
oci_bind_by_name($stid, ':fecha_salida', $fecha_salida_formateada);
oci_bind_by_name($stid, ':estado', $estado);

// Ejecutar el procedimiento
$success = oci_execute($stid);

if ($success) {
    // Redirigir a la página de reservas con un mensaje de éxito
    header('Location: reservas.php?msg=Reserva agregada con éxito');
    exit();
} else {
    // Mostrar el mensaje de error
    $e = oci_error($stid);
    die("Error al agregar reserva: " . htmlentities($e['message'], ENT_QUOTES));
}

// Liberar los recursos y cerrar la conexión
oci_free_statement($stid);
oci_close($conn);
?>
