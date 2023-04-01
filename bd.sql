CREATE TABLE users (
 id int(11) NOT NULL AUTO_INCREMENT,
 role varchar(32) NOT NULL,
 login varchar(32) NOT NULL,
 mdp varchar(32) NOT NULL,
 PRIMARY KEY (`id`) );

CREATE TABLE `vins` (
    `id` int PRIMARY KEY AUTO_INCREMENT ,
    `nom` varchar(32) NOT NULL,
    `couleur` varchar(32) NOT NULL,
    `libelle` varchar(64) NOT NULL,
    `stock` int(10) NOT NULL,
    `prix` int(10) NOT NULL
) ;


ALTER TABLE vins
    ADD CONSTRAINT check_couleur CHECK (couleur IN ('rouge', 'blanc', 'rosé'));

INSERT INTO `vins` (`id`, `nom`, `couleur`, `libelle`, `stock`, `prix`) VALUES (1, 'vin 1', 'rouge', 'libellé 1 ', '99', '12345');
INSERT INTO `vins` (`id`, `nom`, `couleur`, `libelle`, `stock`, `prix`) VALUES (2, 'vin 2', 'rouge', 'libellé 2 ', '99', '12345');
