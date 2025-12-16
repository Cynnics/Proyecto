CREATE DATABASE  IF NOT EXISTS `smartwarehouse_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `smartwarehouse_db`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: smartwarehouse_db
-- ------------------------------------------------------
-- Server version	9.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `albaran`
--

DROP TABLE IF EXISTS `albaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `albaran` (
  `idAlbaran` int NOT NULL AUTO_INCREMENT,
  `idPedido` int DEFAULT NULL,
  `fechaGeneracion` datetime DEFAULT NULL,
  `entregadoPor` int DEFAULT NULL,
  `recibidoPor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'generado',
  PRIMARY KEY (`idAlbaran`),
  KEY `idPedido` (`idPedido`),
  KEY `entregadoPor` (`entregadoPor`),
  CONSTRAINT `albaran_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `albaran_ibfk_2` FOREIGN KEY (`entregadoPor`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `albaran`
--

LOCK TABLES `albaran` WRITE;
/*!40000 ALTER TABLE `albaran` DISABLE KEYS */;
INSERT INTO `albaran` VALUES (23,22,'2025-12-16 07:53:53',3,'','generado');
/*!40000 ALTER TABLE `albaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallepedido`
--

DROP TABLE IF EXISTS `detallepedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallepedido` (
  `idDetalle` int NOT NULL AUTO_INCREMENT,
  `idPedido` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`idDetalle`),
  KEY `idPedido` (`idPedido`),
  KEY `idProducto` (`idProducto`),
  CONSTRAINT `detallepedido_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`),
  CONSTRAINT `detallepedido_ibfk_2` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=74 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallepedido`
--

LOCK TABLES `detallepedido` WRITE;
/*!40000 ALTER TABLE `detallepedido` DISABLE KEYS */;
INSERT INTO `detallepedido` VALUES (52,21,45,3,14.97),(53,21,39,1,19.99),(54,21,17,2,11.98),(55,21,30,2,29.98),(56,21,13,2,39.98),(57,22,50,1,5.60),(58,22,28,1,3.99),(59,22,27,2,11.60),(60,22,21,2,5.98),(61,22,38,1,8.20),(62,23,52,1,4.50),(63,23,44,1,12.49),(64,23,26,1,39.99),(65,23,46,1,2.30),(66,23,41,2,45.00),(67,23,10,2,179.98),(68,24,20,1,9.50),(69,24,7,1,24.50),(70,24,43,1,14.99),(71,24,46,3,6.90),(72,25,39,5,99.95),(73,25,45,1,4.99);
/*!40000 ALTER TABLE `detallepedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `factura`
--

DROP TABLE IF EXISTS `factura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `factura` (
  `idFactura` int NOT NULL AUTO_INCREMENT,
  `idPedido` int DEFAULT NULL,
  `fechaEmision` datetime DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `Activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idFactura`),
  KEY `idPedido` (`idPedido`),
  CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `factura`
--

LOCK TABLES `factura` WRITE;
/*!40000 ALTER TABLE `factura` DISABLE KEYS */;
INSERT INTO `factura` VALUES (32,25,'2025-12-16 07:54:09',104.94,22.04,126.98,1);
/*!40000 ALTER TABLE `factura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `idPedido` int NOT NULL AUTO_INCREMENT,
  `fechaPedido` datetime DEFAULT NULL,
  `estado` enum('pendiente','preparado','en_reparto','entregado') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `idRepartidor` int DEFAULT NULL,
  `FechaEntrega` datetime DEFAULT NULL,
  `ciudad` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `codigoPostal` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `latitud` decimal(10,6) DEFAULT NULL,
  `longitud` decimal(10,6) DEFAULT NULL,
  `DireccionEntrega` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Notas` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`idPedido`),
  KEY `idCliente` (`idCliente`),
  KEY `idRepartidor` (`idRepartidor`),
  CONSTRAINT `pedido_ibfk_1` FOREIGN KEY (`idCliente`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `pedido_ibfk_2` FOREIGN KEY (`idRepartidor`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedido`
--

LOCK TABLES `pedido` WRITE;
/*!40000 ALTER TABLE `pedido` DISABLE KEYS */;
INSERT INTO `pedido` VALUES (21,'2025-12-15 23:40:20','preparado',5,3,NULL,'Madrid','28038',40.391961,-3.639728,'Calle Luis Marin 8','Telefonillo Roto'),(22,'2025-12-15 23:41:04','en_reparto',5,3,NULL,'Madrid','28906',40.315198,-3.703524,'Calle Señora Cornelia 1',NULL),(23,'2025-12-15 23:41:43','pendiente',5,NULL,NULL,'Madrid','28037',40.436420,-3.620475,'Calle de Cronos 8',NULL),(24,'2025-12-15 23:42:20','preparado',5,3,NULL,'Madrid','28038',40.389690,-3.640240,'Calle San Claudio 67',NULL),(25,'2025-12-15 23:45:41','entregado',5,3,'2025-12-15 23:46:57','Madrid','28004',40.422310,-3.705898,'Calle de la Luna 16',NULL);
/*!40000 ALTER TABLE `pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `precio` decimal(10,2) DEFAULT NULL,
  `stock` int DEFAULT NULL,
  `categoria` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `Activo` tinyint DEFAULT '1',
  PRIMARY KEY (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (1,'Cajas de cartón','Pack de 20 cajas de cartón reforzado',19.99,120,'Embalaje',1),(2,'Botella de agua 1L','Botella de agua mineral',0.80,499,'Bebidas',1),(3,'Paquete de folios A4','500 hojas blancas',4.50,300,'Papelería',1),(4,'Café 1kg','Café molido calidad premium',12.90,90,'Alimentación',1),(5,'Huevos XL','Docena de huevos extra grandes',3.20,200,'Alimentación',1),(6,'Lámpara LED de escritorio','Lámpara ajustable de luz blanca con base estable',12.99,120,'Hogar',1),(7,'Teclado inalámbrico','Teclado Bluetooth compacto y silencioso',24.50,79,'Electrónica',1),(8,'Mouse óptico USB','Ratón ergonómico de alta precisión',9.99,150,'Electrónica',1),(9,'Cuaderno A5 tapa dura','Cuaderno de notas con 200 hojas rayadas',4.20,300,'Oficina',1),(10,'Silla ergonómica','Silla de oficina con soporte lumbar',89.99,28,'Oficina',1),(11,'Juego de tazas cerámicas','Set de 4 tazas resistentes al microondas',14.95,59,'Cocina',1),(12,'Botella térmica 500ml','Botella de acero inoxidable mantiene la temperatura',11.50,199,'Deportes',1),(13,'Cajonera plástica','Cajonera de 4 niveles para organización',19.99,42,'Hogar',1),(14,'Destornillador multipunta','Incluye múltiples puntas intercambiables',8.75,90,'Herramientas',1),(15,'Pila alcalina AAA (pack 10)','Pilas de larga duración',6.80,300,'Electrónica',1),(16,'Cargador USB doble','Cargador rápido de dos puertos',7.40,110,'Electrónica',1),(17,'Auriculares con cable','Auriculares ligeros de alta fidelidad',5.99,115,'Electrónica',1),(18,'Colador metálico','Colador de acero inoxidable',3.50,79,'Cocina',1),(19,'Sartén antiadherente 24cm','Revestimiento cerámico resistente',17.99,55,'Cocina',1),(20,'Toalla de baño','Toalla de algodón 120x70cm',9.50,99,'Hogar',1),(21,'Jabón líquido para manos','Botella de 500ml aroma neutro',2.99,248,'Limpieza',1),(22,'Detergente líquido 1L','Detergente para lavar ropa',4.99,200,'Limpieza',1),(23,'Escoba de cerdas suaves','Escoba resistente con mango de aluminio',6.40,68,'Limpieza',1),(24,'Cinta adhesiva transparente','Rollo de 40m',1.20,350,'Oficina',1),(25,'Archivador A4','Carpeta de archivo con palanca metálica',2.50,175,'Oficina',1),(26,'Router WiFi','Router de doble banda 2.4/5G',39.99,24,'Electrónica',1),(27,'Extensión eléctrica 3m','Extensión con tres tomas',5.80,98,'Hogar',1),(28,'Funda para almohada','Tela suave antialérgica',3.99,139,'Hogar',1),(29,'Plancha de ropa','Plancha eléctrica con vapor',22.99,40,'Hogar',1),(30,'Bote de basura 20L','Basurero con tapa abatible',14.99,51,'Hogar',1),(31,'Cuerda para saltar','Cuerda ajustable para ejercicio',3.50,75,'Deportes',1),(32,'Mancuernas 2kg','Par de mancuernas recubiertas de neopreno',16.99,30,'Deportes',1),(33,'Comedero para perro','Plato plástico antideslizante',4.80,60,'Mascotas',1),(34,'Shampoo para perro 500ml','Aroma neutro hipoalergénico',6.50,50,'Mascotas',1),(35,'Linterna LED','Linterna portátil de alta potencia',9.90,90,'Herramientas',1),(36,'Martillo de carpintero','Mango de madera y cabeza de acero',7.50,70,'Herramientas',1),(37,'Cable HDMI 2m','Cable de alta velocidad 4K',5.99,130,'Electrónica',1),(38,'Memoria USB 32GB','Unidad flash de alto rendimiento',8.20,99,'Electrónica',1),(39,'Almohada viscoelástica','Almohada ergonómica',19.99,20,'Hogar',1),(40,'Sábana matrimonial','Juego de sábanas 100% algodón',24.99,35,'Hogar',1),(41,'Set de cuchillos','Set de 5 cuchillos con base',22.50,48,'Cocina',1),(42,'Tabla para cortar','Tabla de bambú resistente',6.99,90,'Cocina',1),(43,'Ventilador de escritorio','Ventilador compacto con varias velocidades',14.99,59,'Electrónica',1),(44,'Reloj despertador digital','Pantalla LED con alarma doble',12.49,69,'Hogar',1),(45,'Alargador USB-C','Cable USB-C a USB-C de 1m',4.99,111,'Electrónica',1),(46,'Portaminas 0.7mm','Portaminas metálico con agarre cómodo',2.30,196,'Oficina',1),(47,'Pack de bolígrafos','Set de 10 bolígrafos tinta azul',1.99,300,'Oficina',1),(48,'Grapadora metálica','Incluye 1000 grapas',3.99,90,'Oficina',1),(49,'Cepillo para platos','Cerdas firmes para limpieza profunda',2.20,109,'Cocina',1),(50,'Guantes de cocina','Guantes térmicos resistentes al calor',5.60,68,'Cocina',1),(51,'Pegamento universal 50ml','Fuerte adhesión multiuso',1.80,160,'Oficina',1),(52,'Rallador metálico','Rallador de acero inoxidable',4.50,79,'Cocina',1),(53,'Batería recargable 18650','Batería de litio de alta capacidad',7.99,88,'Electrónica',1);
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutaentrega`
--

DROP TABLE IF EXISTS `rutaentrega`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutaentrega` (
  `idRuta` int NOT NULL AUTO_INCREMENT,
  `idRepartidor` int DEFAULT NULL,
  `fechaRuta` date DEFAULT NULL,
  `distanciaEstimadaKm` decimal(5,2) DEFAULT NULL,
  `duracionEstimadaMin` int DEFAULT NULL,
  `estado` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idRuta`),
  KEY `idRepartidor` (`idRepartidor`),
  CONSTRAINT `rutaentrega_ibfk_1` FOREIGN KEY (`idRepartidor`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutaentrega`
--

LOCK TABLES `rutaentrega` WRITE;
/*!40000 ALTER TABLE `rutaentrega` DISABLE KEYS */;
INSERT INTO `rutaentrega` VALUES (17,3,'2025-12-15',1.15,5,'pendiente'),(18,3,'2025-12-15',13.68,13,'en_curso'),(19,3,'2025-12-15',13.96,21,'completada');
/*!40000 ALTER TABLE `rutaentrega` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rutapedido`
--

DROP TABLE IF EXISTS `rutapedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rutapedido` (
  `idRuta` int NOT NULL,
  `idPedido` int NOT NULL,
  PRIMARY KEY (`idRuta`,`idPedido`),
  KEY `idPedido` (`idPedido`),
  CONSTRAINT `rutapedido_ibfk_1` FOREIGN KEY (`idRuta`) REFERENCES `rutaentrega` (`idRuta`),
  CONSTRAINT `rutapedido_ibfk_2` FOREIGN KEY (`idPedido`) REFERENCES `pedido` (`idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rutapedido`
--

LOCK TABLES `rutapedido` WRITE;
/*!40000 ALTER TABLE `rutapedido` DISABLE KEYS */;
INSERT INTO `rutapedido` VALUES (17,21),(18,22),(17,24),(19,25);
/*!40000 ALTER TABLE `rutapedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ubicacionrepartidor`
--

DROP TABLE IF EXISTS `ubicacionrepartidor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ubicacionrepartidor` (
  `idUbicacion` int NOT NULL AUTO_INCREMENT,
  `idRepartidor` int DEFAULT NULL,
  `latitud` decimal(10,6) DEFAULT NULL,
  `longitud` decimal(10,6) DEFAULT NULL,
  `fechaHora` datetime DEFAULT NULL,
  PRIMARY KEY (`idUbicacion`),
  KEY `idRepartidor` (`idRepartidor`),
  CONSTRAINT `ubicacionrepartidor_ibfk_1` FOREIGN KEY (`idRepartidor`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=1262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ubicacionrepartidor`
--

LOCK TABLES `ubicacionrepartidor` WRITE;
/*!40000 ALTER TABLE `ubicacionrepartidor` DISABLE KEYS */;
INSERT INTO `ubicacionrepartidor` VALUES (1261,1,40.389660,-3.639270,'2025-12-15 23:43:36');
/*!40000 ALTER TABLE `ubicacionrepartidor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `rol` enum('admin','empleado','repartidor','cliente') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `telefono` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `DireccionFacturacion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `NIF` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Administrador','admin@admin.com','123','admin','612345678',NULL,NULL),(2,'Laura Gómez','empleado@gmail.com','emple123','empleado','678901234',NULL,NULL),(3,'Juan Pérez','repartidor1@gmail.com','rep123','repartidor','699876543',NULL,NULL),(4,'María López','repartidor2@gmail.com','rep123','repartidor','622334455',NULL,NULL),(5,'Carlos Ruizz','cliente1@gmail.com','cli123','cliente','655443300','Calle Los Robles 123, 4B, Madrid','12345678A'),(6,'Ana Sánchez','cliente2@gmail.com','cli123','cliente','677889900','Avenida Libertad 55, 2A, Sevilla','98765432B');
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-12-16  7:57:58
