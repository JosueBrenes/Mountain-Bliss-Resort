<?php
include '../../../database/database.php';

if (!$conn) {
    die("Conexión fallida: " . htmlentities(oci_error()['message'], ENT_QUOTES));
}

if (!isset($_GET['id']) || empty($_GET['id'])) {
    die("ID del empleado no proporcionado.");
}

$empleado_id = $_GET['id'];

// Preparar la llamada al procedimiento almacenado
$query = 'BEGIN obtener_empleados(:cursor); END;';
$stid = oci_parse($conn, $query);

// Crear un cursor para el resultado
$cursor = oci_new_cursor($conn);

// Bind variables
oci_bind_by_name($stid, ':cursor', $cursor, -1, OCI_B_CURSOR);

// Ejecutar la consulta
if (!oci_execute($stid)) {
    $e = oci_error($stid);
    die("Error en la ejecución de la consulta: " . htmlentities($e['message'], ENT_QUOTES));
}

// Ejecutar el cursor
if (!oci_execute($cursor)) {
    $e = oci_error($cursor);
    die("Error en la ejecución del cursor: " . htmlentities($e['message'], ENT_QUOTES));
}

// Buscar el empleado con el ID proporcionado
$empleado = null;
while (($row = oci_fetch_assoc($cursor)) !== false) {
    if ($row['EMPLEADOID'] == $empleado_id) {
        $empleado = $row;
        break;
    }
}

// Verificar si se encontró el empleado
if (!$empleado) {
    die("No se encontró el empleado.");
}

// Formatear la fecha de contratación
$fecha_contratacion = $empleado['FECHACONTRATACION'] ? date('Y-m-d', strtotime($empleado['FECHACONTRATACION'])) : '';

// Liberar los recursos
oci_free_statement($stid);
oci_free_statement($cursor);
oci_close($conn);
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Editar Empleado - Mountain-Bliss-Resort</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
    <link rel="stylesheet" href="../../../public/build/css/styles.css" />
    <link rel="icon" href="../../../public/build/img/icon.png" type="image/x-icon" />
    <link rel="shortcut icon" href="../../../public/build/img/icon.png" type="image/x-icon" />
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
                <h1 style="color: #333">Editar Empleado</h1>
                <form action="actualizar_empleado.php" method="POST">
                    <input type="hidden" name="empleado_id" value="<?php echo htmlspecialchars($empleado['EMPLEADOID'], ENT_QUOTES); ?>">
                    <div class="form-group">
                        <label for="nombre">Nombre</label>
                        <input type="text" id="nombre" name="nombre" class="form-control" value="<?php echo htmlspecialchars($empleado['NOMBRE'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="apellido">Apellido</label>
                        <input type="text" id="apellido" name="apellido" class="form-control" value="<?php echo htmlspecialchars($empleado['APELLIDO'], ENT_QUOTES); ?>" required>
                    </div>
                    <div class="form-group">
                        <label for="puesto">Puesto</label>
                        <input type="text" id="puesto" name="puesto" class="form-control" value="<?php echo htmlspecialchars($empleado['PUESTO'], ENT_QUOTES); ?>">
                    </div>
                    <div class="form-group">
                        <label for="fecha_contratacion">Fecha de Contratación</label>
                        <input type="date" id="fecha_contratacion" name="fecha_contratacion" class="form-control" value="<?php echo htmlspecialchars($fecha_contratacion, ENT_QUOTES); ?>">
                    </div>
                    <div class="form-group">
                        <label for="salario">Salario</label>
                        <input type="number" id="salario" name="salario" class="form-control" step="0.01" value="<?php echo htmlspecialchars($empleado['SALARIO'], ENT_QUOTES); ?>">
                    </div>
                    <button type="submit" class="btn" style="background-color: #013e6a; color: white; margin-bottom: 2rem;">Actualizar Empleado</button>
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
