<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del inventario no proporcionado.");
}

$inventario_id = $_GET['id'];

$sql = 'SELECT * FROM Inventarios WHERE InventarioID = :inventario_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':inventario_id', $inventario_id);
oci_execute($stid);
$inventario = oci_fetch_assoc($stid);

if (!$inventario) {
    die("No se encontró el inventario.");
}

oci_free_statement($stid);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Inventario - Mountain-Bliss-Resort</title>
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
                <h1 style="color: #333">Editar Inventario</h1>
                <form action="actualizar_inventario.php" method="POST">
                    <input type="hidden" name="inventario_id" value="<?php echo htmlspecialchars($inventario['INVENTARIOID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="nombre_producto">Nombre del Producto</label>
                        <input type="text" id="nombre_producto" name="nombre_producto" class="form-control" value="<?php echo htmlspecialchars($inventario['NOMBREPRODUCTO'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="cantidad_total">Cantidad Total</label>
                        <input type="number" id="cantidad_total" name="cantidad_total" class="form-control" value="<?php echo htmlspecialchars($inventario['CANTIDADTOTAL'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="unidad_medida">Unidad de Medida</label>
                        <input type="text" id="unidad_medida" name="unidad_medida" class="form-control" value="<?php echo htmlspecialchars($inventario['UNIDADMEDIDA'], ENT_QUOTES); ?>">
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Inventario</button>
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
