-- ---------------------------------------------------------------------------------------------
-- SELECTING DATABASE: 'tifosi'
-- ---------------------------------------------------------------------------------------------

USE tifosi;


-- --------------------------------------------------------------------------------
-- 1 -- Display a list in ascending alphabetical order of the focaccias' names
-- -------------------------------------------------------------------------------- 

SELECT nom FROM focaccia ORDER BY nom ASC;

-- Expected output: one column with the name "nom" and the name of each focaccia ordered like this:
-- Américaine, Emmentalaccia, Gorgonzollaccia, Hawaienne, Mozaccia, Paysanne, Raclaccia, Tradizione

-- -------------------------------------------------------------------

-- Obtained output:
-- +-----------------+
-- | nom             |
-- +-----------------+
-- | Américaine      |
-- | Emmentalaccia   |
-- | Gorgonzollaccia |
-- | Hawaienne       |
-- | Mozaccia        |
-- | Paysanne        |
-- | Raclaccia       |
-- | Tradizione      |
-- +-----------------+



-- --------------------------------------------------------------------------------
-- 2 -- Display the total number of ingredients
-- -------------------------------------------------------------------------------- 

SELECT COUNT(nom) FROM ingredient;

-- Expected output: 25

-- --------------------------------------------------------------------

-- Obtained output:
-- +------------+
-- | COUNT(nom) |
-- +------------+
-- |         25 |
-- +------------+



-- --------------------------------------------------------------------------------
-- 3 -- Display the average price of the focaccias
-- -------------------------------------------------------------------------------- 

SELECT ROUND(AVG(prix), 2) FROM `focaccia`;

-- Expected output: 10.375

-- Obtained output:
-- +---------------------+
-- | ROUND(AVG(prix), 2) |
-- +---------------------+
-- |               10.38 |
-- +---------------------+
--
-- ROUND() allows to round the result up to the next highest number by specifying the
-- maximum number of decimal places to display (here 2). That's why we have 10.38 
-- instead of 10.375, which is the result you obtain with a classic calculator.


-- --------------------------------------------------------------------------------
-- 4 -- Display the beverages list with their brand, ordered by beverage name.
-- -------------------------------------------------------------------------------- 

SELECT boisson.nom as nom_boisson, marque.nom as marque
FROM `boisson`
INNER JOIN `marque`
ON boisson.id_marque = marque.id_marque
ORDER BY boisson.nom ASC;

-- Expected output: a 2-columns table with a column "nom_boisson" where all the beverages
-- are ordered alphabetically and a column "marque" where the name of the beverage brand
-- is displayed.

-- Obtained output:
-- +---------------------------+-------------+
-- | nom_boisson               | marque      |
-- +---------------------------+-------------+
-- | Capri-sun                 | Coca-Cola   |
-- | Coca-cola original        | Coca-Cola   |
-- | Coca-cola zéro            | Coca-Cola   |
-- | Eau de source             | Cristalline |
-- | Fanta citron              | Coca-Cola   |
-- | Fanta orange              | Coca-Cola   |
-- | Lipton Peach              | Pepsico     |
-- | Lipton zéro citron        | Pepsico     |
-- | Monster energy ultra bleu | Monster     |
-- | Monster energy ultra gold | Monster     |
-- | Pepsi                     | Pepsico     |
-- | Pepsi Max Zéro            | Pepsico     |
-- +---------------------------+-------------+



-- --------------------------------------------------------------------------------
-- 5 -- Display the ingredients list for a Raclaccia
-- -------------------------------------------------------------------------------- 

SELECT i.nom, c.quantite
FROM comprend as c
JOIN ingredient as i
ON c.id_ingredient = i.id_ingredient
WHERE c.id_focaccia = 3
ORDER BY i.nom;

-- Expected output: a 2-columns table with the first column "nom" displaying the name of
-- the ingredient needed for the Raclaccia only (ordered alphabetically) and the second 
-- one "quantite" displaying the quantity needed for each ingredient.

-- Obtained output:
-- +-------------+----------+
-- | nom         | quantite |
-- +-------------+----------+
-- | Ail         |        2 |
-- | Base Tomate |      200 |
-- | Champignon  |       40 |
-- | Cresson     |       20 |
-- | Parmesan    |       50 |
-- | Poivre      |        1 |
-- | Raclette    |       50 |
-- +-------------+----------+



-- --------------------------------------------------------------------------------
-- 6 -- Display the name and the number of ingredients for each focaccia
-- -------------------------------------------------------------------------------- 

SELECT 
  f.nom AS focaccia, 
  COUNT(i.id_ingredient) AS nombre_ingredients,
  GROUP_CONCAT(i.nom ORDER BY i.nom SEPARATOR ', ') AS nom_ingredients
FROM focaccia as f
JOIN comprend as c ON f.id_focaccia = c.id_focaccia
JOIN ingredient as i ON c.id_ingredient = i.id_ingredient
GROUP BY f.id_focaccia
ORDER BY f.nom;

-- Expected output: a 3-columns table with the first column "focaccia" displaying the name
-- of the focaccias (ordered alphabetically), the second column "nombre_ingredients" displaying
-- the number of ingredients for each focaccia and the last column "nom_ingredients" displaying
-- a list with the name of those ingredients for each focaccia.

-- Obtained output:
-- +-----------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------+
-- | focaccia        | nombre_ingredients | nom_ingredients                                                                                                             |
-- +-----------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------+
-- | Américaine      |                  8 | Bacon, Base Tomate, Cresson, Mozarella, Olive noire, Parmesan, Poivre, Pomme de terre                                       |
-- | Emmentalaccia   |                  7 | Base crème, Champignon, Cresson, Emmental, Oignon, Parmesan, Poivre                                                         |
-- | Gorgonzollaccia |                  8 | Ail, Base Tomate, Champignon, Cresson, Gorgonzola, Olive noire, Parmesan, Poivre                                            |
-- | Hawaienne       |                  9 | Ananas, Bacon, Base Tomate, Cresson, Mozarella, Olive noire, Parmesan, Piment, Poivre                                       |
-- | Mozaccia        |                 10 | Ail, Artichaut, Base Tomate, Champignon, Cresson, Jambon fumé, Mozarella, Olive noire, Parmesan, Poivre                     |
-- | Paysanne        |                 12 | Ail, Artichaut, Base crème, Champignon, Chevre, Cresson, Jambon fumé, Oeuf, Olive noire, Parmesan, Poivre, Pomme de terre   |
-- | Raclaccia       |                  7 | Ail, Base Tomate, Champignon, Cresson, Parmesan, Poivre, Raclette                                                           |
-- | Tradizione      |                  9 | Base Tomate, Champignon, Cresson, Jambon cuit, Mozarella, Olive noire, Olive verte, Parmesan, Poivre                        |
-- +-----------------+--------------------+-----------------------------------------------------------------------------------------------------------------------------+



-- --------------------------------------------------------------------------------
-- 7 -- Display the name of the focaccia containing the most ingredients
-- -------------------------------------------------------------------------------- 

SELECT f.nom 
FROM focaccia as f 
JOIN comprend as c ON f.id_focaccia = c.id_focaccia
JOIN ingredient as i ON c.id_ingredient = i.id_ingredient 
GROUP BY f.id_focaccia
HAVING COUNT(i.id_ingredient) = (
  SELECT MAX(nb) 
  FROM (
    SELECT COUNT(*) AS nb
    FROM comprend
    GROUP BY id_focaccia
  ) AS sous
);

-- Expected output: Paysanne

-- Obtained output:
-- +----------+
-- | nom      |
-- +----------+
-- | Paysanne |
-- +----------+
--
-- If you also want to display its number of ingredients, use the following script.

SELECT f.nom, COUNT(i.id_ingredient) AS nombre_ingredients 
FROM focaccia as f 
JOIN comprend as c ON f.id_focaccia = c.id_focaccia
JOIN ingredient as i ON c.id_ingredient = i.id_ingredient 
GROUP BY f.id_focaccia
HAVING COUNT(i.id_ingredient) = (
  SELECT MAX(nb) 
  FROM (
    SELECT COUNT(*) AS nb
    FROM comprend
    GROUP BY id_focaccia
  ) AS sous
);

-- Expected output: "Paysanne | 12"

-- Obtained output:
-- +----------+--------------------+
-- | nom      | nombre_ingredients |
-- +----------+--------------------+
-- | Paysanne |                 12 |
-- +----------+--------------------+



-- --------------------------------------------------------------------------------
-- 8 -- Display the list of the focaccias containing garlic
-- -------------------------------------------------------------------------------- 

SELECT f.nom 
FROM focaccia as f
JOIN comprend as c ON f.id_focaccia = c.id_focaccia
JOIN ingredient as i ON c.id_ingredient = i.id_ingredient
WHERE i.id_ingredient = 1
GROUP BY f.id_focaccia
ORDER BY f.nom ASC;

-- Expected output: Gorgonzollaccia, Mozaccia, Paysanne, Raclaccia

-- Obtained output:
-- +-----------------+
-- | nom             |
-- +-----------------+
-- | Gorgonzollaccia |
-- | Mozaccia        |
-- | Paysanne        |
-- | Raclaccia       |
-- +-----------------+



-- --------------------------------------------------------------------------------
-- 9 -- Display the list of the unused ingredients
-- -------------------------------------------------------------------------------- 

SELECT i.nom AS ingredients_inutilises
FROM ingredient as i
LEFT JOIN comprend as c ON i.id_ingredient = c.id_ingredient
WHERE c.id_ingredient IS NULL;

-- Expected output: Salami, Tomate cerise

-- Obtained output:
-- +------------------------+
-- | ingredients_inutilises |
-- +------------------------+
-- | Salami                 |
-- | Tomate cerise          |
-- +------------------------+




-- --------------------------------------------------------------------------------
-- 10 -- Display the list of the focaccias without mushrooms
-- -------------------------------------------------------------------------------- 

SELECT f.nom AS focaccia
FROM focaccia as f
WHERE NOT EXISTS (
    SELECT 1
    FROM comprend as c
    WHERE c.id_focaccia = f.id_focaccia
    AND c.id_ingredient = 7
);

-- Or you can also use this script.

SELECT f.nom AS focaccia
FROM focaccia as f
LEFT JOIN comprend as c ON f.id_focaccia = c.id_focaccia AND c.id_ingredient = 7
WHERE c.id_ingredient IS NULL;

-- Expected output: Hawaienne, Américaine

-- Obtained output:
-- +-------------+
-- | focaccia    |
-- +-------------+
-- | Hawaienne   |
-- | Américaine  |
-- +-------------+

