<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

// Obtener el ID de la habitación a editar
$habitacion_id = $_GET['id'] ?? '';

if (empty($habitacion_id)) {
    die("ID de habitación no proporcionado.");
}

// Consultar los datos de la habitación
$sql = 'SELECT * FROM Habitaciones WHERE HabitacionID = :habitacion_id';
$stid = oci_parse($conn, $sql);
oci_bind_by_name($stid, ':habitacion_id', $habitacion_id);
oci_execute($stid);

$habitacion = oci_fetch_assoc($stid);

if (!$habitacion) {
    die("Habitación no encontrada.");
}

oci_free_statement($stid);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Habitación - Mountain-Bliss-Resort</title>
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
            <div class="container">
                <div class="row">
                    <div class="container mt-5">
                        <h1 style="color: #333">Editar Habitación</h1>
                        <form action="actualizar_habitacion.php" method="POST">
                            <input type="hidden" name="habitacion_id" value="<?php echo htmlspecialchars($habitacion['HABITACIONID']); ?>">
                            <div class="form-group">
                                <label for="numero_habitacion">Número de Habitación</label>
                                <input type="text" id="numero_habitacion" name="numero_habitacion" class="form-control" value="<?php echo htmlspecialchars($habitacion['NUMEROHABITACION']); ?>" required>
                            </div>
                            <div class="form-group">
                                <label for="tipo_habitacion">Tipo de Habitación</label>
                                <input type="text" id="tipo_habitacion" name="tipo_habitacion" class="form-control" value="<?php echo htmlspecialchars($habitacion['TIPOHABITACION']); ?>">
                            </div>
                            <div class="form-group">
                                <label for="precio_por_noche">Precio por Noche</label>
                                <input type="number" id="precio_por_noche" name="precio_por_noche" step="0.01" class="form-control" value="<?php echo htmlspecialchars($habitacion['PRECIOPORNOCHE']); ?>">
                            </div>
                            <div class="form-group">
                                <label for="estado">Estado</label>
                                <select id="estado" name="estado" class="form-control">
                                    <option value="Disponible" <?php if ($habitacion['ESTADO'] == 'Disponible') echo 'selected'; ?>>Disponible</option>
                                    <option value="Ocupada" <?php if ($habitacion['ESTADO'] == 'Ocupada') echo 'selected'; ?>>Ocupada</option>
                                    <option value="Mantenimiento" <?php if ($habitacion['ESTADO'] == 'Mantenimiento') echo 'selected'; ?>>Mantenimiento</option>
                                </select>
                            </div>
                            <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Habitación</button>
                        </form>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer_area">
            <p class="footer_text">&copy; 2024 Mountain-Bliss-Resort. Todos los derechos reservados.</p>
        </footer>
    </div>
</body>
</html>
