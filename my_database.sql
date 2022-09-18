-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: db:3306
-- Tiempo de generación: 18-09-2022 a las 19:11:49
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

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`id`, `name`, `first_name`, `last_name`, `address`, `state`, `city`, `email`, `password`) VALUES
(1, 'Tyshawn Doyle', 'Alvina', 'Streich', '91272 Nyah Coves\nWest Pierreburgh, IL 54131', 'Swaziland', 'Evafort', 'salma.brakus@fay.com', '.J8l1\\uN>w'),
(2, 'Uriel Kertzmann', 'Pete', 'Baumbach', '89739 Isac Station\nOsbaldoville, GA 47602', 'Philippines', 'Larkinburgh', 'geovanny27@hotmail.com', 'gN_E~X{N\'a9rBe5hu:'),
(3, 'Kiara Carroll', 'Myles', 'Ratke', '413 Goyette Coves\nWest Bradyton, WY 22380-2188', 'Taiwan', 'East Hoseabury', 'lebsack.alyson@feeney.net', ',M3A[4{v?9f&\'I=.=0'),
(4, 'Miss Marisa Gusikowski Jr.', 'Berenice', 'Predovic', '1760 King Canyon\nNorth Penelopeland, AZ 70384', 'Zimbabwe', 'Anastasialand', 'tate.murphy@olson.info', 'w}G=VyBp'),
(5, 'Chloe Orn', 'Mariam', 'O\'Hara', '13586 Mallory Mountains\nLake Catherinemouth, MO 75556', 'Georgia', 'North Everardo', 'stoltenberg.rosamond@gmail.com', 'Q(f?\\DcHZR'),
(6, 'Loraine Stracke', 'Aiyana', 'Frami', '8044 Grimes Ways\nEast Meredith, NJ 37837', 'Samoa', 'Littelchester', 'marvin.isobel@gerlach.com', 'v=L:78A?|/!~AZPo$449'),
(7, 'Maye Hagenes', 'Jacklyn', 'Hauck', '83539 Schamberger Club\nWest Nola, NM 27474-7052', 'Monaco', 'Lake Noemihaven', 'christophe12@erdman.org', '+ME_ZV^LMu#u~'),
(8, 'Clementina McKenzie', 'Zelda', 'Armstrong', '8160 Arnoldo Fork\nEast Joanfurt, VA 89541-2456', 'Bahrain', 'Carlostown', 'miller.emmett@yahoo.com', 's=KI1Iw%\'Y='),
(9, 'Leonie O\'Hara', 'Cameron', 'Funk', '753 Grady Harbors Apt. 513\nSkilestown, CO 04138', 'Tokelau', 'South Oliverport', 'amber.jacobi@gmail.com', '5*AsjHe'),
(10, 'Thora Pagac', 'Tevin', 'Wolf', '96956 Julie Forest\nAlanaside, WI 71613', 'Netherlands', 'Lake Georgianahaven', 'quincy71@gmail.com', 'I:Z3]QIh-MS');

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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `user`
--

INSERT INTO `user` (`id`, `name`, `email`, `roles`, `password`) VALUES
(1, 'admin', 'admin@admin.com', '[\"ROLE_ADMIN\"]', '$2y$13$lsejG4lXEzd6hHSC6glx3Ojjg.C3qdZAturk5uFF0g4VKRW6kUbom');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`id`);

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
-- Indices de la tabla `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `customer`
--
ALTER TABLE `customer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

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

--
-- AUTO_INCREMENT de la tabla `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
