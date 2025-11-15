-- ---------------------------------------------------------------------------------------------
-- DATABASE: 'tifosi'
-- ---------------------------------------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS `tifosi` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE tifosi;

-- ---------------------------------------------------------------------------------------------
-- 
-- TABLE STRUCTURE: 'ingredient'
--

CREATE TABLE IF NOT EXISTS ingredient (
    id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'focaccia'
--

CREATE TABLE IF NOT EXISTS focaccia (
    id_focaccia INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'menu'
--

CREATE TABLE IF NOT EXISTS menu (
    id_menu INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL,
    id_focaccia INT NOT NULL,

--
-- RELATIONS FOR TABLE 'menu'
--  `id_focaccia`
--      `focaccia` -> `id_focaccia`
--

    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'marque'
--

CREATE TABLE IF NOT EXISTS marque (
    id_marque INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'boisson'
--

CREATE TABLE IF NOT EXISTS boisson (
    id_boisson INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    id_marque INT NOT NULL,

-- RELATIONS FOR TABLE 'boisson'
--  `id_marque`
--      `marque` -> `id_marque`
--

    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
-- 
-- TABLE STRUCTURE: 'client'
--

CREATE TABLE IF NOT EXISTS client (
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    code_postal INT NOT NULL
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'comprend'
--

CREATE TABLE IF NOT EXISTS comprend (
    id_focaccia INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite INT NOT NULL,
    PRIMARY KEY (id_focaccia, id_ingredient),

--
-- RELATIONS FOR TABLE 'comprend'
--  `id_focaccia`
--      `focaccia` -> `id_focaccia`
--  `id_ingredient`
--      `ingredient` -> `id_ingredient`
--

    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'contient'
--

CREATE TABLE IF NOT EXISTS contient (
        id_menu INT NOT NULL,
        id_boisson INT NOT NULL,
        PRIMARY KEY (id_menu, id_boisson),

--
-- RELATIONS FOR TABLE 'contient'
--  `id_menu`
--      `menu` -> `id_menu`
--  `id_boisson`
--      `boisson` -> `id_boisson`
--

        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
        FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
            ON UPDATE CASCADE
            ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------------------------------



-- ---------------------------------------------------------------------------------------------
--
-- TABLE STRUCTURE: 'achete'
--

CREATE TABLE IF NOT EXISTS achete (
        id_client INT NOT NULL,
        id_menu INT NOT NULL,
        date_achat DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
        PRIMARY KEY (id_client, id_menu),

--
-- RELATIONS FOR TABLE 'achete'
--  `id_client`
--      `client` -> `id_client`
--  `id_menu`
--      `menu` -> `id_menu`
--

        FOREIGN KEY (id_client) REFERENCES client(id_client)
            ON UPDATE CASCADE
            ON DELETE CASCADE,
        FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
            ON UPDATE CASCADE
            ON DELETE CASCADE
) ENGINE=InnoDB

-- ---------------------------------------------------------------------------------------------