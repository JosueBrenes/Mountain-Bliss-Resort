<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID de la factura no proporcionado.");
}

$factura_id = $_GET['id'];

$sql = 'SELECT * FROM Facturacion WHERE FacturaID = :factura_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':factura_id', $factura_id);
oci_execute($stid);
$factura = oci_fetch_assoc($stid);

if (!$factura) {
    die("No se encontró la factura.");
}

$fecha_factura = date('Y-m-d', strtotime($factura['FECHAFACTURA']));

oci_free_statement($stid);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Facturación - Mountain-Bliss-Resort</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../public/build/css/styles.css" />
    <link rel="icon" href="../public/build/img/icon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="../public/build/img/icon.png" type="image/x-icon" />
</head>
<body>
    <!-- Sidebar -->
    <nav class="sidebar">
        <h2>Opciones Administrativas</h2>
        <a href="../../paginas/huespedes/huespedes.php">Gestionar Huéspedes</a>
        <a href="../../paginas/empleados/empleados.php">Gestionar Empleados</a>
        <a href="../../paginas/habitaciones/habitaciones.php">Gestionar Habitaciones</a>
        <a href="../../paginas/reservas/reservas.php">Gestionar Reservas</a>
        <a href="../../paginas/servicios/servicios.php">Gestionar Servicios</a>
        <a href="../../paginas/facturacion/facturacion.php">Gestionar Facturación</a>
        <a href="../../paginas/inventarios/inventarios.php">Gestionar Inventarios</a>
        <a href="../../paginas/inventarios/cantidad_inventario_por_habitacion.php">Ver Cantidades de Inventario</a>
        <a href="../../paginas/mantenimiento/mantenimiento.php">Gestionar Mantenimiento</a>
        <a href="../../paginas/proovedores/proveedores.php">Gestionar Proveedores</a>
    </nav>

    <!-- Content -->
    <div class="content">
        <!-- Header -->
        <header class="header_area">
            <a href="../../../public/index.php" class="header_link">
                <h1>Mountain-Bliss-Resort</h1>
            </a>
        </header>

        <!-- Main Content -->
        <section class="options_area">
            <div class="container mt-5">
                <h1 style="color: #333">Editar Facturación</h1>
                <form action="actualizar_facturacion.php" method="POST">
                    <input type="hidden" name="factura_id" value="<?php echo htmlspecialchars($factura['FACTURAID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="reserva_id">ID de la Reserva</label>
                        <input type="number" id="reserva_id" name="reserva_id" class="form-control" value="<?php echo htmlspecialchars($factura['RESERVAID'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="fecha_factura">Fecha de la Factura</label>
                        <input type="date" id="fecha_factura" name="fecha_factura" class="form-control" value="<?php echo htmlspecialchars($fecha_factura, ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="total">Total</label>
                        <input type="number" id="total" name="total" class="form-control" step="0.01" value="<?php echo htmlspecialchars($factura['TOTAL'], ENT_QUOTES); ?>" required>
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Factura</button>
                </form>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer_area">
            <p class="footer_text">&copy; 2024 Mountain-Bliss-Resort. Todos los derechos reservados.</p>
        </footer>
    </div>
</body>
</html>
