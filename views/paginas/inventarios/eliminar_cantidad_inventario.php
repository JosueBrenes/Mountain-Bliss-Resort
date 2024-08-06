<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['habitacion_id']) && isset($_GET['inventario_id'])) {
    $habitacionId = $_GET['habitacion_id'];
    $inventarioId = $_GET['inventario_id'];

    $deleteSql = 'DELETE FROM CantidadInventarioPorHabitacion WHERE HabitacionID = :habitacion_id AND InventarioID = :inventario_id';
    $deleteStid = oci_parse($conn, $deleteSql);
    oci_bind_by_name($deleteStid, ':habitacion_id', $habitacionId);
    oci_bind_by_name($deleteStid, ':inventario_id', $inventarioId);
    
    if (oci_execute($deleteStid)) {
        echo "<script>alert('Cantidad de inventario eliminada con éxito.'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
    } else {
        $e = oci_error($deleteStid);
        echo "<script>alert('Error al eliminar la cantidad de inventario: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
    }

    oci_free_statement($deleteStid);
} else {
    echo "<script>alert('ID de habitación o inventario no especificado.'); window.location.href='cantidad_inventario_por_habitacion.php';</script>";
}

oci_close($conn);
?>
