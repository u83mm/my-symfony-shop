-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: db:3306
-- Tiempo de generación: 17-09-2022 a las 17:57:17
-- Versión del servidor: 10.8.3-MariaDB-1:10.8.3+maria~jammy
-- Versión de PHP: 8.0.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `my_database`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

CREATE TABLE `customer` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `doctrine_migration_versions`
--

CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Volcado de datos para la tabla `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20220916222911', '2022-09-16 22:30:45', 106),
('DoctrineMigrations\\Version20220917093906', '2022-09-17 11:39:20', 78),
('DoctrineMigrations\\Version20220917174401', '2022-09-17 19:44:13', 75),
('DoctrineMigrations\\Version20220917174626', '2022-09-17 19:46:31', 58);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `messenger_messages`
--

CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `product`
--

INSERT INTO `product` (`id`, `name`, `description`, `price`, `image`) VALUES
(52, 'Mouse.', 'Odio dolorum reiciendis tempore ad laudantium omnis deserunt. Nisi ut hic in architecto dolorem ducimus ut. Et atque laudantium fugit aspernatur.', '32.33', 'images/products/bass-ic-lh.png'),
(53, 'Queen.', 'Sed in libero sequi et facere modi. Dolor est architecto quia quaerat quis eaque voluptate. Aliquid deleniti voluptate soluta et laudantium qui.', '493.50', 'images/products/bass-ic.png'),
(54, 'And so.', 'Quisquam voluptatem ratione vel est accusantium. Magnam similique dolor architecto quo molestias. Repellat quae debitis et aperiam consequatur vel id.', '300.50', 'images/products/btr300.png'),
(55, 'Latitude.', 'Animi consectetur quis voluptatibus quo asperiores repellat. Magni quod reprehenderit rem pariatur.', '24.25', 'images/products/fg700s.png'),
(56, 'Alice.', 'Consequatur laudantium ducimus est. Animi sint dicta voluptatem numquam recusandae aperiam. Amet nobis voluptas animi natus ut asperiores.', '493.00', 'images/products/hofner.png'),
(57, 'I!\' said.', 'Quo similique officiis repellat recusandae quae. Modi amet quisquam blanditiis tempore culpa nesciunt voluptas. Esse iste aut rem similique. Quasi consequatur enim dolores consequuntur fugit.', '233.00', 'images/products/ibanez.png'),
(58, 'Duchess.', 'Est culpa eum aut nesciunt expedita vero consectetur. Occaecati libero deserunt aut dolorem aliquam magni. Possimus non deleniti assumenda ex ad esse. Aut quia ut sed reiciendis dignissimos.', '103.50', 'images/products/precision.png'),
(59, 'Alice.', 'Quam at quisquam delectus repellat suscipit. Et officia ipsam molestiae.', '174.20', 'images/products/les_paul.png'),
(60, 'Hatter.', 'Expedita unde earum explicabo officiis et dolor voluptas libero. Et ab et quis. Sit qui aut similique nihil et quia.', '75.80', 'images/products/ludwig.png'),
(61, 'MUST be.', 'Sit quam sapiente velit blanditiis. Voluptas doloribus error et est ut corrupti. Praesentium incidunt magnam reiciendis excepturi aliquid. Non magni itaque exercitationem facere ut molestias.', '423.00', 'images/products/pearl.png');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `doctrine_migration_versions`
--
ALTER TABLE `doctrine_migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indices de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  ADD KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  ADD KEY `IDX_75EA56E016BA31DB` (`delivered_at`);

--
-- Indices de la tabla `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `messenger_messages`
--
ALTER TABLE `messenger_messages`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
