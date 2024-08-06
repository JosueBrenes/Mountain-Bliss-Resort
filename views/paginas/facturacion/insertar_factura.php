<?php
include '../../../database/database.php';

if (!$conn) {
    echo "No se pudo conectar a la base de datos.";
    exit;
}

$reserva_id = $_POST['reserva_id'];
$fecha_factura = $_POST['fecha_factura'];
$total = $_POST['total'];

try {
    $fecha_factura_dt = new DateTime($fecha_factura);
    $fecha_factura_formateada = $fecha_factura_dt->format('Y-m-d');
} catch (Exception $e) {
    echo "Error al formatear la fecha: " . $e->getMessage();
    exit;
}

$query = 'SELECT Factura_SEQ.NEXTVAL AS id_factura FROM dual';
$stid = oci_parse($conn, $query);
oci_execute($stid);
$row = oci_fetch_assoc($stid);
$id_factura = $row['ID_FACTURA'];

$sql = 'INSERT INTO Facturacion (FacturaID, ReservaID, FechaFactura, Total) 
        VALUES (:id_factura, :reserva_id, TO_DATE(:fecha_factura, \'YYYY-MM-DD\'), :total)';
$stid = oci_parse($conn, $sql);

oci_bind_by_name($stid, ':id_factura', $id_factura);
oci_bind_by_name($stid, ':reserva_id', $reserva_id);
oci_bind_by_name($stid, ':fecha_factura', $fecha_factura_formateada);
oci_bind_by_name($stid, ':total', $total);

$success = oci_execute($stid);

if ($success) {
    header('Location: facturacion.php');
    exit();
} else {
    $e = oci_error($stid);
    echo "Error al agregar facturación: " . $e['message'];
}

oci_free_statement($stid);
oci_close($conn);
?>
