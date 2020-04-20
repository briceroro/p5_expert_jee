-- Adminer 4.7.6 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP DATABASE IF EXISTS `mydb`;
CREATE DATABASE `mydb` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mydb`;

DROP TABLE IF EXISTS `adresses_clients`;
CREATE TABLE `adresses_clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `numero` varchar(45) DEFAULT NULL,
  `rue` varchar(45) DEFAULT NULL,
  `code postal` varchar(45) DEFAULT NULL,
  `ville` varchar(45) DEFAULT NULL,
  `complement` varchar(45) DEFAULT NULL,
  `clients_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_adresses_clients1_idx` (`clients_id`),
  CONSTRAINT `fk_adresses_clients1` FOREIGN KEY (`clients_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `adresses_clients` (`id`, `numero`, `rue`, `code postal`, `ville`, `complement`, `clients_id`) VALUES
(1,	'15',	'du confinement',	'44360',	'galere',	NULL,	1),
(2,	'1',	'de la pic',	'75020',	'paname',	NULL,	1);

DROP TABLE IF EXISTS `clients`;
CREATE TABLE `clients` (
  `id` int NOT NULL AUTO_INCREMENT,
  `points fidelite` int DEFAULT NULL,
  `tel` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_clients_user1_idx` (`user_id`),
  CONSTRAINT `fk_clients_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `clients` (`id`, `points fidelite`, `tel`, `user_id`) VALUES
(1,	0,	652635263,	1);

DROP TABLE IF EXISTS `commandes`;
CREATE TABLE `commandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adresses_clients_id` int NOT NULL,
  `livreurs_id` int NOT NULL,
  `date` datetime DEFAULT NULL,
  `statut` varchar(45) DEFAULT NULL,
  `restaurants_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_commandes_adresses1_idx` (`adresses_clients_id`),
  KEY `fk_commandes_livreurs1_idx` (`livreurs_id`),
  KEY `fk_commandes_restaurants1_idx` (`restaurants_id`),
  CONSTRAINT `fk_commandes_adresses1` FOREIGN KEY (`adresses_clients_id`) REFERENCES `adresses_clients` (`id`),
  CONSTRAINT `fk_commandes_livreurs1` FOREIGN KEY (`livreurs_id`) REFERENCES `livreurs` (`id`),
  CONSTRAINT `fk_commandes_restaurants1` FOREIGN KEY (`restaurants_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `commandes` (`id`, `adresses_clients_id`, `livreurs_id`, `date`, `statut`, `restaurants_id`) VALUES
(1,	1,	1,	'2020-01-01 00:00:00',	'livrée',	1);

DROP TABLE IF EXISTS `composition_commandes`;
CREATE TABLE `composition_commandes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commandes_id` int NOT NULL,
  `stock_produits_id` int DEFAULT NULL,
  `pizza_id` int DEFAULT NULL,
  `quantité` int DEFAULT NULL,
  `prix` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_composition_commandes_commandes1_idx` (`commandes_id`),
  KEY `fk_composition_commandes_stock_produits1_idx` (`stock_produits_id`),
  KEY `fk_composition_commandes_pizza1_idx` (`pizza_id`),
  CONSTRAINT `fk_composition_commandes_commandes1` FOREIGN KEY (`commandes_id`) REFERENCES `commandes` (`id`),
  CONSTRAINT `fk_composition_commandes_pizza1` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`id`),
  CONSTRAINT `fk_composition_commandes_stock_produits1` FOREIGN KEY (`stock_produits_id`) REFERENCES `stock_produits` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `composition_commandes` (`id`, `commandes_id`, `stock_produits_id`, `pizza_id`, `quantité`, `prix`) VALUES
(1,	1,	6,	NULL,	1,	2),
(2,	1,	NULL,	1,	1,	12);

DROP TABLE IF EXISTS `composition_pizza`;
CREATE TABLE `composition_pizza` (
  `stock_produits_id` int NOT NULL,
  `pizza_id` int NOT NULL,
  `quantité` int NOT NULL,
  PRIMARY KEY (`stock_produits_id`,`pizza_id`),
  KEY `fk_stock_produits_has_pizza_pizza1_idx` (`pizza_id`),
  KEY `fk_stock_produits_has_pizza_stock_produits1_idx` (`stock_produits_id`),
  CONSTRAINT `fk_stock_produits_has_pizza_pizza1` FOREIGN KEY (`pizza_id`) REFERENCES `pizza` (`id`),
  CONSTRAINT `fk_stock_produits_has_pizza_stock_produits1` FOREIGN KEY (`stock_produits_id`) REFERENCES `stock_produits` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `composition_pizza` (`stock_produits_id`, `pizza_id`, `quantité`) VALUES
(1,	1,	1),
(1,	2,	2),
(2,	1,	1),
(2,	2,	2),
(5,	1,	1),
(5,	2,	2);

DROP TABLE IF EXISTS `employés`;
CREATE TABLE `employés` (
  `id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  KEY `fk_employés_user1_idx` (`user_id`),
  CONSTRAINT `fk_employés_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `employés` (`id`, `role`, `user_id`) VALUES
(1,	'pizzaiolo',	2),
(2,	'gerant',	3),
(3,	'livreur',	4);

DROP TABLE IF EXISTS `livreurs`;
CREATE TABLE `livreurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `position_longitude` decimal(50,30) DEFAULT NULL,
  `position_magnitude` decimal(50,30) DEFAULT NULL,
  `statut` tinyint DEFAULT NULL,
  `employés_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `employés_id_UNIQUE` (`employés_id`),
  KEY `fk_livreurs_employés1_idx` (`employés_id`),
  CONSTRAINT `fk_livreurs_employés1` FOREIGN KEY (`employés_id`) REFERENCES `employés` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `livreurs` (`id`, `position_longitude`, `position_magnitude`, `statut`, `employés_id`) VALUES
(1,	NULL,	NULL,	1,	3);

DROP TABLE IF EXISTS `paiments`;
CREATE TABLE `paiments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `commandes_id` int NOT NULL,
  `numero_transaction` int DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `statut` varchar(45) DEFAULT NULL,
  `montant` varchar(45) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_paiments_commandes1_idx` (`commandes_id`),
  CONSTRAINT `fk_paiments_commandes1` FOREIGN KEY (`commandes_id`) REFERENCES `commandes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `paiments` (`id`, `commandes_id`, `numero_transaction`, `type`, `statut`, `montant`, `date`) VALUES
(2,	1,	1252125821,	'cb',	'success',	'10',	'2020-01-01'),
(3,	1,	NULL,	'espece',	'success',	'4',	'2020-01-01');

DROP TABLE IF EXISTS `pizza`;
CREATE TABLE `pizza` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `descriptif` varchar(45) DEFAULT NULL,
  `prix` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `pizza` (`id`, `nom`, `descriptif`, `prix`) VALUES
(1,	'margarita small',	'1 dose de chaque : farine,tomate,fromage',	12),
(2,	'margarita double',	'2 dose de chaque:farine,tomate,fromage',	16);

DROP TABLE IF EXISTS `restaurants`;
CREATE TABLE `restaurants` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) DEFAULT NULL,
  `code postal` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `restaurants` (`id`, `nom`, `code postal`) VALUES
(1,	'paris 14',	75014),
(2,	'corona city',	99560);

DROP TABLE IF EXISTS `stock_produits`;
CREATE TABLE `stock_produits` (
  `id` int NOT NULL AUTO_INCREMENT,
  `employés_id` int NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `type` varchar(45) DEFAULT NULL,
  `descriptif` varchar(45) DEFAULT NULL,
  `quantité` int DEFAULT NULL,
  `prix` decimal(10,0) DEFAULT NULL,
  `restaurants_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_stock_produits_employés1_idx` (`employés_id`),
  KEY `fk_stock_produits_restaurants1_idx` (`restaurants_id`),
  CONSTRAINT `fk_stock_produits_employés1` FOREIGN KEY (`employés_id`) REFERENCES `employés` (`id`),
  CONSTRAINT `fk_stock_produits_restaurants1` FOREIGN KEY (`restaurants_id`) REFERENCES `restaurants` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `stock_produits` (`id`, `employés_id`, `nom`, `type`, `descriptif`, `quantité`, `prix`, `restaurants_id`) VALUES
(1,	2,	'farine',	'ingrédient',	'1 dose = 0.1 kg',	400,	NULL,	1),
(2,	2,	'sauce tomate',	'ingredient',	'1 dose = 0.05 litre',	400,	NULL,	1),
(3,	2,	'lardon',	'ingredient',	'1 dose = 0.050 kg',	75,	NULL,	1),
(4,	2,	'canette soda',	'boisson',	'',	300,	1,	1),
(5,	2,	'fromage rapé',	'ingredient',	'1 dose = 0.1 kg',	400,	NULL,	1),
(6,	2,	'glace',	'dessert',	NULL,	200,	2,	2);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mdp` varchar(45) DEFAULT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `mail` varchar(45) DEFAULT NULL,
  `create_time` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user` (`id`, `mdp`, `nom`, `prenom`, `mail`, `create_time`) VALUES
(1,	'mdp',	'user',	'1',	'user@gpadmail.com',	'2020-01-01'),
(2,	'mdp',	'user',	'2',	'user@gpadmail.com',	'2020-01-01'),
(3,	'mdp',	'user',	'3',	'user@gpadmail.com',	'2020-01-01'),
(4,	'mdp',	'user',	'4',	'user@gpadmail.com',	'2020-01-01');

-- 2020-04-20 13:42:45
