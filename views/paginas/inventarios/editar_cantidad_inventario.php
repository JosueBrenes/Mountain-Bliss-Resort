<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['habitacion_id']) || !isset($_GET['inventario_id']) || empty($_GET['habitacion_id']) || empty($_GET['inventario_id'])) {
    die("ID de habitación o de inventario no proporcionado.");
}

$habitacion_id = $_GET['habitacion_id'];
$inventario_id = $_GET['inventario_id'];

$sql = 'SELECT * FROM CantidadInventarioPorHabitacion WHERE HabitacionID = :habitacion_id AND InventarioID = :inventario_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_bind_by_name($stid, ':inventario_id', $inventario_id);
oci_execute($stid);
$cantidad_inventario = oci_fetch_assoc($stid);

if (!$cantidad_inventario) {
    die("No se encontró la cantidad de inventario para la habitación y el inventario proporcionados.");
}

oci_free_statement($stid);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Cantidad de Inventario - Mountain-Bliss-Resort</title>
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
                <h1 style="color: #333">Editar Cantidad de Inventario</h1>
                <form action="actualizar_cantidad_inventario.php" method="POST">
                    <input type="hidden" name="habitacion_id" value="<?php echo htmlspecialchars($cantidad_inventario['HABITACIONID'], ENT_QUOTES); ?>">
                    <input type="hidden" name="inventario_id" value="<?php echo htmlspecialchars($cantidad_inventario['INVENTARIOID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="cantidad">Cantidad</label>
                        <input type="number" id="cantidad" name="cantidad" class="form-control" value="<?php echo htmlspecialchars($cantidad_inventario['CANTIDAD'], ENT_QUOTES); ?>" required>
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Cantidad</button>
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
