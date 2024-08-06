<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID de la reserva no proporcionado.");
}

$reserva_id = $_GET['id'];

$sql = 'SELECT * FROM Reservas WHERE ReservaID = :reserva_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':reserva_id', $reserva_id);
oci_execute($stid);
$reserva = oci_fetch_assoc($stid);

if (!$reserva) {
    die("No se encontró la reserva.");
}

// Convertir las fechas a formato adecuado
$fecha_entrada = date('Y-m-d', strtotime($reserva['FECHAENTRADA']));
$fecha_salida = date('Y-m-d', strtotime($reserva['FECHASALIDA']));

oci_free_statement($stid);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Reserva - Mountain-Bliss-Resort</title>
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
                <h1 style="color: #333">Editar Reserva</h1>
                <form action="actualizar_reserva.php" method="POST">
                    <input type="hidden" name="reserva_id" value="<?php echo htmlspecialchars($reserva['RESERVAID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="huesped_id">ID del Huésped</label>
                        <input type="number" id="huesped_id" name="huesped_id" class="form-control" value="<?php echo htmlspecialchars($reserva['HUESPEDID'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="habitacion_id">ID de la Habitación</label>
                        <input type="number" id="habitacion_id" name="habitacion_id" class="form-control" value="<?php echo htmlspecialchars($reserva['HABITACIONID'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="fecha_entrada">Fecha de Entrada</label>
                        <input type="date" id="fecha_entrada" name="fecha_entrada" class="form-control" value="<?php echo htmlspecialchars($fecha_entrada, ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="fecha_salida">Fecha de Salida</label>
                        <input type="date" id="fecha_salida" name="fecha_salida" class="form-control" value="<?php echo htmlspecialchars($fecha_salida, ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="estado">Estado</label>
                        <select id="estado" name="estado" class="form-control" required>
                            <option value="Pendiente" <?php echo ($reserva['ESTADO'] == 'Pendiente') ? 'selected' : ''; ?>>Pendiente</option>
                            <option value="Confirmada" <?php echo ($reserva['ESTADO'] == 'Confirmada') ? 'selected' : ''; ?>>Confirmada</option>
                            <option value="Cancelada" <?php echo ($reserva['ESTADO'] == 'Cancelada') ? 'selected' : ''; ?>>Cancelada</option>
                        </select>
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Reserva</button>
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
