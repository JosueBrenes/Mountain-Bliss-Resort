<header class="navbar">
  <a href="../public/index.php">
    <img src="../public/build/img/logo.png" alt="Logo" />
  </a>
  <nav class="menu">
    <a href="./index.php">Inicio</a>
    <a href="../views/paginas/services.php">Servicios</a>
    <a href="../views/paginas/prices.php">Precios</a>
    <a href="../views/paginas/about_us.php">Sobre nosotros</a>
    <?php
      session_start();
      $loggedIn = isset($_SESSION['correo']);
      ?>
    <?php if ($loggedIn): ?>
    <a href="../views/paginas/bookings.php">Reservaciones</a>
    <a href="../views/auth/logout.php" class="btn-login">Cerrar sesión</a>
    <?php else: ?>
    <a href="../views/auth/login.php" class="btn-login">Iniciar sesión</a>
    <?php endif; ?>
    <a
      href="../views/paginas/contact_us.php"
      class="btn-contact"
      style="background-color: #F54670"
      >Contáctenos</a
    >
  </nav>
</header>
