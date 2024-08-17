<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID de mantenimiento no proporcionado.");
}

$mantenimiento_id = $_GET['id'];

// Preparar el cursor
$sql = 'BEGIN obtener_mantenimiento(:p_cursor); END;';
$stid = oci_parse($conn, $sql);

// Crear un cursor
$cursor = oci_new_cursor($conn);
oci_bind_by_name($stid, ':p_cursor', $cursor, -1, OCI_B_CURSOR);
oci_execute($stid);

// Ejecutar el cursor para obtener los datos
oci_execute($cursor);
$mantenimiento = null;
while ($row = oci_fetch_assoc($cursor)) {
    if ($row['MANTENIMIENTOID'] == $mantenimiento_id) {
        $mantenimiento = $row;
        break;
    }
}

if (!$mantenimiento) {
    die("No se encontró el mantenimiento.");
}

$fecha_mantenimiento = date('Y-m-d', strtotime($mantenimiento['FECHAMANTENIMIENTO']));

oci_free_statement($stid);
oci_free_statement($cursor);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Mantenimiento - Mountain-Bliss-Resort</title>
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
                <h1 style="color: #333">Editar Mantenimiento</h1>
                <form action="actualizar_mantenimiento.php" method="POST">
                    <input type="hidden" name="mantenimiento_id" value="<?php echo htmlspecialchars($mantenimiento['MANTENIMIENTOID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="habitacion_id">ID de la Habitación</label>
                        <input type="number" id="habitacion_id" name="habitacion_id" class="form-control" value="<?php echo htmlspecialchars($mantenimiento['HABITACIONID'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="descripcion">Descripción</label>
                        <textarea id="descripcion" name="descripcion" class="form-control"><?php echo htmlspecialchars($mantenimiento['DESCRIPCION'], ENT_QUOTES); ?></textarea>
                    </div>
                    <div class="form-group">
                        <label for="fecha_mantenimiento">Fecha de Mantenimiento</label>
                        <input type="date" id="fecha_mantenimiento" name="fecha_mantenimiento" class="form-control" value="<?php echo htmlspecialchars($fecha_mantenimiento, ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="costo">Costo</label>
                        <input type="number" id="costo" name="costo" class="form-control" step="0.01" value="<?php echo htmlspecialchars($mantenimiento['COSTO'], ENT_QUOTES); ?>" required>
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Mantenimiento</button>
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
