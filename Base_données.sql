-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:8889
-- Généré le :  ven. 27 juil. 2018 à 13:53
-- Version du serveur :  5.6.38
-- Version de PHP :  7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `ExpressFood`
--

-- --------------------------------------------------------

--
-- Structure de la table `chef`
--

CREATE TABLE `chef` (
  `idchef` int(11) NOT NULL,
  `prenom_chef` varchar(45) NOT NULL,
  `nom_chef` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `idclient` int(11) NOT NULL,
  `prenom_client` varchar(45) NOT NULL,
  `nom_client` varchar(45) NOT NULL,
  `adresse_client` varchar(300) NOT NULL,
  `telephone_client` int(11) NOT NULL,
  `cartepaiement_client` int(11) DEFAULT NULL,
  `date_creation_compte_client` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`idclient`, `prenom_client`, `nom_client`, `adresse_client`, `telephone_client`, `cartepaiement_client`, `date_creation_compte_client`) VALUES
(1, 'Aurelie', 'Tudare', 'Rue du Temple 75003', 650690972, NULL, '2018-07-26'),
(2, 'Jacques', 'Martin', 'rue de la fac 75002', 678987651, NULL, '2018-07-26'),
(3, 'Eric', 'Martin', 'Impasse de la Rampée 75002', 768987654, NULL, '2018-07-26'),
(4, 'Vivien', 'Rahel', 'Place de la résistance 75020', 678954323, NULL, '2018-07-26'),
(5, 'Sophie', 'Dupont', 'Rue de la pierre qui roule', 689937854, NULL, '2018-07-16'),
(6, 'Sophiane', 'Shra', 'Vallée de la montagne', 789543612, NULL, '2018-07-14');

-- --------------------------------------------------------

--
-- Structure de la table `commande`
--

CREATE TABLE `commande` (
  `idcommande` int(11) NOT NULL,
  `date_commande` datetime NOT NULL,
  `choix_paiement` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'En ligne',
  `livraison_idlivraison` int(11) NOT NULL,
  `facture_idfacture` int(11) NOT NULL,
  `client_idclient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `email`
--

CREATE TABLE `email` (
  `idemail` int(11) NOT NULL,
  `email` varchar(100) NOT NULL,
  `client_idclient` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `email`
--

INSERT INTO `email` (`idemail`, `email`, `client_idclient`) VALUES
(1, 'aurelie@gmail.com', 1),
(2, 'tudare@gmail.com', 1),
(3, 'jacques.martin@gmail.com', 2);

-- --------------------------------------------------------

--
-- Structure de la table `facture`
--

CREATE TABLE `facture` (
  `idfacture` int(11) NOT NULL,
  `total_ht` decimal(10,0) DEFAULT NULL,
  `taux_tva_100` decimal(10,0) DEFAULT NULL,
  `total_ttc` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `ligne_commande`
--

CREATE TABLE `ligne_commande` (
  `idligne_commande` int(11) NOT NULL,
  `quantite_produit_commande` varchar(45) NOT NULL,
  `commande_idcommande` int(11) NOT NULL,
  `menu_idplat_du_jour` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `livraison`
--

CREATE TABLE `livraison` (
  `idlivraison` int(11) NOT NULL,
  `adresse_livraison` varchar(300) NOT NULL,
  `temps_estime_livraison` int(11) NOT NULL,
  `livreur_idlivreur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `livreur`
--

CREATE TABLE `livreur` (
  `idlivreur` int(11) NOT NULL,
  `prenom_livreur` varchar(45) NOT NULL,
  `nom_livreur` varchar(45) NOT NULL,
  `statut_livreur` tinyint(4) NOT NULL,
  `position_gps_livreur` float NOT NULL,
  `stock_livreur` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `menu`
--

CREATE TABLE `menu` (
  `idplat_du_jour` int(11) NOT NULL,
  `date_creation_plat` date NOT NULL,
  `nom_plat_du_jour` varchar(45) NOT NULL,
  `quantite_plat_stock` int(11) NOT NULL,
  `prix_plat` decimal(10,0) NOT NULL,
  `chef_idchef` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `chef`
--
ALTER TABLE `chef`
  ADD PRIMARY KEY (`idchef`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`idclient`);

--
-- Index pour la table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`idcommande`,`livraison_idlivraison`,`facture_idfacture`),
  ADD KEY `fk_commande_livraison1_idx` (`livraison_idlivraison`),
  ADD KEY `fk_commande_facture1_idx` (`facture_idfacture`),
  ADD KEY `fk_commande_client1_idx` (`client_idclient`);

--
-- Index pour la table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`idemail`,`client_idclient`),
  ADD KEY `fk_email_client1_idx` (`client_idclient`);

--
-- Index pour la table `facture`
--
ALTER TABLE `facture`
  ADD PRIMARY KEY (`idfacture`);

--
-- Index pour la table `ligne_commande`
--
ALTER TABLE `ligne_commande`
  ADD PRIMARY KEY (`idligne_commande`,`commande_idcommande`,`menu_idplat_du_jour`),
  ADD KEY `fk_ligne_commande_commande1_idx` (`commande_idcommande`),
  ADD KEY `fk_ligne_commande_menu1_idx` (`menu_idplat_du_jour`);

--
-- Index pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD PRIMARY KEY (`idlivraison`),
  ADD KEY `fk_livraison_livreur1_idx` (`livreur_idlivreur`);

--
-- Index pour la table `livreur`
--
ALTER TABLE `livreur`
  ADD PRIMARY KEY (`idlivreur`);

--
-- Index pour la table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`idplat_du_jour`),
  ADD KEY `fk_menu_chef_idx` (`chef_idchef`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `chef`
--
ALTER TABLE `chef`
  MODIFY `idchef` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `idclient` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `commande`
--
ALTER TABLE `commande`
  MODIFY `idcommande` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `email`
--
ALTER TABLE `email`
  MODIFY `idemail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `facture`
--
ALTER TABLE `facture`
  MODIFY `idfacture` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livraison`
--
ALTER TABLE `livraison`
  MODIFY `idlivraison` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `livreur`
--
ALTER TABLE `livreur`
  MODIFY `idlivreur` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `menu`
--
ALTER TABLE `menu`
  MODIFY `idplat_du_jour` int(11) NOT NULL AUTO_INCREMENT;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `fk_commande_client1` FOREIGN KEY (`client_idclient`) REFERENCES `client` (`idclient`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_facture1` FOREIGN KEY (`facture_idfacture`) REFERENCES `facture` (`idfacture`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_commande_livraison1` FOREIGN KEY (`livraison_idlivraison`) REFERENCES `livraison` (`idlivraison`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `email`
--
ALTER TABLE `email`
  ADD CONSTRAINT `fk_email_client1` FOREIGN KEY (`client_idclient`) REFERENCES `client` (`idclient`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ligne_commande`
--
ALTER TABLE `ligne_commande`
  ADD CONSTRAINT `fk_ligne_commande_commande1` FOREIGN KEY (`commande_idcommande`) REFERENCES `commande` (`idcommande`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_ligne_commande_menu1` FOREIGN KEY (`menu_idplat_du_jour`) REFERENCES `menu` (`idplat_du_jour`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `livraison`
--
ALTER TABLE `livraison`
  ADD CONSTRAINT `fk_livraison_livreur1` FOREIGN KEY (`livreur_idlivreur`) REFERENCES `livreur` (`idlivreur`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `menu`
--
ALTER TABLE `menu`
  ADD CONSTRAINT `fk_menu_chef` FOREIGN KEY (`chef_idchef`) REFERENCES `chef` (`idchef`) ON DELETE NO ACTION ON UPDATE NO ACTION;
