-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 26 août 2023 à 18:59
-- Version du serveur : 5.7.36
-- Version de PHP : 8.0.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `video_center_samir_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20230819131719', '2023-08-19 13:17:35', 167),
('DoctrineMigrations\\Version20230819135805', '2023-08-20 13:41:19', 232),
('DoctrineMigrations\\Version20230820125559', '2023-08-20 14:56:43', 223),
('DoctrineMigrations\\Version20230820131218', '2023-08-20 15:12:42', 340),
('DoctrineMigrations\\Version20230820210047', '2023-08-20 23:01:10', 124),
('DoctrineMigrations\\Version20230821121630', '2023-08-21 14:16:44', 336),
('DoctrineMigrations\\Version20230821140133', '2023-08-21 16:01:39', 206),
('DoctrineMigrations\\Version20230824111611', '2023-08-24 13:16:23', 302),
('DoctrineMigrations\\Version20230825132451', '2023-08-25 15:25:30', 194);

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `is_verified` tinyint(1) NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_1483A5E9E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `is_verified`, `image_name`, `image_size`) VALUES
(1, 'samirmesmoudi@hotmail.com', '[]', '$2y$13$80mNR4Gi1jqXj4z6oe09ieg3shtqzo5iRA91mD6zrwj/hvyHUjIBm', 'samir', 'mesmoudi', '2023-08-21 15:08:45', '2023-08-25 17:48:07', 1, 'cfitech-64e8cd37f00a6636062800.png', 11340),
(2, 'assiaattahoumi@hotmail.com', '[]', '$2y$13$uLkbagDncZxtOgGP9MyBm.569NjJ7/5kQaiXtmSvqejVA31zEbP0W', 'assia', 'attahoumi', '2023-08-22 16:13:57', '2023-08-25 17:47:19', 2, 'profile-64e8cd0761acf716799848.jpeg', 4074),
(3, 'ismaelmesmoudi@hotmail.com', '[]', '$2y$13$crQHbNJm80uGskaHgTrxHOxPEigkjIYKn1oaJYgnQoq4L.qHrRiI2', 'ismael', 'mesmoudi', '2023-08-22 16:16:05', '2023-08-25 17:46:12', 1, 'profile-64e8ccc49664a208903648.jpeg', 4074),
(4, 'jamesbond@hotmail.com', '[]', '$2y$13$QSa5Y7ltc5sbU5ICXYqPgOTqlTOHR6341sG.9WDe0zwP6x7Oi2q7O', 'james', 'bond', '2023-08-22 16:17:07', '2023-08-22 16:17:07', 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_link` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '(DC2Type:datetime_immutable)',
  `user_id` int(11) NOT NULL,
  `premium_video` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_29AA6432A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `user_id`, `premium_video`) VALUES
(1, 'OPPENHEIMER', 'https://www.youtube.com/embed/CoXtvSRpHgM', 'Bande annonce en Version Francaise', '2023-08-25 19:27:57', '2023-08-25 19:45:15', 1, 0),
(2, 'AVATAR 3', 'https://www.youtube.com/embed/YXtWPVFk5TQ', 'Official Trailer  20th Century Studios', '2023-08-25 19:30:08', '2023-08-25 19:30:08', 1, 0),
(3, 'Avatar 2', 'https://www.youtube.com/embed/V_pb0BT2USk', 'Bande-annonce officielle (VF)', '2023-08-25 21:51:52', '2023-08-25 21:51:52', 1, 0),
(4, 'Five Nights At Freddy\'s', 'https://www.youtube.com/embed/e4K9g9a1_is', 'Bande annonce VF [Au cinéma le 8 novembre]', '2023-08-25 21:58:38', '2023-08-25 21:58:38', 1, 0),
(5, 'THE VISIT', 'https://www.youtube.com/embed/IBlHQHJJEJU', 'Bande-annonce VF [Au Cinéma le 7 octobre]', '2023-08-25 22:01:30', '2023-08-25 22:01:30', 3, 0),
(6, 'BLACK PHONE', 'https://www.youtube.com/embed/KF72P2Ews2A', 'Bande annonce VF [Au cinéma le 22 juin]', '2023-08-25 22:02:36', '2023-08-25 22:02:36', 3, 0),
(7, 'MIGRATION', 'https://www.youtube.com/embed/aqoonSGBYUg', 'Bande annonce VOST [Au cinéma le 6 décembre]', '2023-08-25 22:04:41', '2023-08-25 22:04:41', 2, 0),
(8, 'COMPLETEMENT CRAMER!', 'https://www.youtube.com/embed/X-Mx7OQay9o', 'Bande-annonce [Au cinéma le 1er novembre]', '2023-08-25 22:09:05', '2023-08-25 22:09:05', 2, 0),
(9, 'NAPOLEON', 'https://www.youtube.com/embed/znPkppmeFTM', 'Bande Annonce VF (2023)', '2023-08-25 22:20:26', '2023-08-25 22:20:26', 1, 1),
(10, 'WONKA', 'https://www.youtube.com/embed/yPmOnBX_7Ww', 'Bande Annonce VF (2023)', '2023-08-25 22:27:01', '2023-08-25 22:27:01', 1, 1),
(11, 'DUNE 2', 'https://www.youtube.com/embed/Cc2ToZFyTQY', 'Bande Annonce VF (Nouvelle, 2023)', '2023-08-25 22:30:30', '2023-08-25 22:30:30', 1, 1),
(12, 'RETRIBUTION', 'https://www.youtube.com/embed/jzQn0-WH4WM', '(2023) Official Trailer', '2023-08-26 13:36:47', '2023-08-26 13:36:47', 1, 1),
(13, 'THE COVONANT', 'https://www.youtube.com/embed/91Jhw-NaN9s', 'Bande Annonce VF (2023)', '2023-08-26 13:39:02', '2023-08-26 13:39:02', 3, 1),
(14, 'THE CREATOR', 'https://www.youtube.com/embed/573GCxqkYEg', 'Teaser Trailer | 20th Century Studios', '2023-08-26 13:41:04', '2023-08-26 13:41:04', 3, 1),
(15, 'EXPENDABLES 4', 'https://www.youtube.com/embed/Cm3Z1jEjHHc', 'Official Red Band Trailer 2023', '2023-08-26 13:43:22', '2023-08-26 13:43:22', 3, 1),
(16, 'KRAVEN', 'https://www.youtube.com/embed/UwCaeFD3U4Y', 'Bande Annonce VF (2023)', '2023-08-26 13:44:49', '2023-08-26 13:44:49', 3, 1),
(17, 'ALIEN ROMULUS', 'https://www.youtube.com/embed/dL0XLpl3SiA', 'Trailer (2024) | Hulu', '2023-08-26 13:47:48', '2023-08-26 13:47:48', 2, 1),
(18, 'THE PENGUIN', 'https://www.youtube.com/embed/wcIOpkDoOx4', 'Teaser Trailer (2024)', '2023-08-26 13:49:15', '2023-08-26 13:49:15', 2, 1),
(19, 'THE FLASH', 'https://www.youtube.com/embed/m0uNUeE3cNk', 'Bande Annonce VF Finale (2023)', '2023-08-26 13:52:58', '2023-08-26 13:52:58', 2, 1),
(20, 'TRUE DETECTIVE', 'https://www.youtube.com/embed/hmJHKF2bYVc', 'Season 4 Trailer (2023)', '2023-08-26 13:55:30', '2023-08-26 13:55:30', 2, 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_29AA6432A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
