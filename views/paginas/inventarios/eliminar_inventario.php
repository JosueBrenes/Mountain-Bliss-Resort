<?php
include '../../../database/database.php'; 

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (isset($_GET['id'])) {
    $inventarioId = $_GET['id'];

    // Preparar la consulta para eliminar los registros dependientes en CantidadInventarioPorHabitacion
    $deleteDependentsSql = 'DELETE FROM CantidadInventarioPorHabitacion WHERE InventarioID = :id';
    $deleteDependentsStid = oci_parse($conn, $deleteDependentsSql);
    oci_bind_by_name($deleteDependentsStid, ':id', $inventarioId);
    
    $dependentsDeleted = oci_execute($deleteDependentsStid);
    oci_free_statement($deleteDependentsStid);

    if ($dependentsDeleted) {
        // Ahora eliminar el registro en Inventarios
        $deleteSql = 'DELETE FROM Inventarios WHERE InventarioID = :id';
        $deleteStid = oci_parse($conn, $deleteSql);
        oci_bind_by_name($deleteStid, ':id', $inventarioId);
        
        if (oci_execute($deleteStid)) {
            echo "<script>alert('Inventario eliminado con éxito.'); window.location.href='inventarios.php';</script>";
        } else {
            $e = oci_error($deleteStid); 
            echo "<script>alert('Error al eliminar el inventario: " . htmlentities($e['message'], ENT_QUOTES) . "'); window.location.href='inventarios.php';</script>";
        }

        oci_free_statement($deleteStid);
    } else {
        echo "<script>alert('Error al eliminar registros dependientes.'); window.location.href='inventarios.php';</script>";
    }
} else {
    echo "<script>alert('ID no especificado.'); window.location.href='inventarios.php';</script>";
}

oci_close($conn);
?>
