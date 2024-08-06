<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID de la habitación no proporcionado.");
}

$habitacion_id = $_GET['id'];

// Preparar la consulta SQL para eliminar el registro
$sql = 'DELETE FROM Habitaciones WHERE HabitacionID = :habitacion_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);

if (oci_execute($stid)) {
    // Redirigir a la página principal de habitaciones con un mensaje de éxito
    header('Location: habitaciones.php?msg=Habitación eliminada con éxito');
} else {
    $error = oci_error($stid);
    die("Error al eliminar la habitación: " . htmlentities($error['message'], ENT_QUOTES));
}

oci_free_statement($stid);
oci_close($conn);
?>
