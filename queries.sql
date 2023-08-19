/*Queries that provide answers to the questions from all projects.*/
SELECT
    *
FROM
    animals
WHERE
    lower(name) LIKE '%mon';

SELECT
    name
FROM
    animals
WHERE
    date_of_birth BETWEEN '2016-01-01'
    AND '2019-12-31';

SELECT
    name
FROM
    animals
WHERE
    neutured = true
    AND escape_attempts < 3;

SELECT
    date_of_birth
FROM
    animals
WHERE
    name IN ('Agumon', 'Pikachu');

SELECT
    name,
    escape_attempts
FROM
    animals
WHERE
    weight_kg > 10.5;

SELECT
    *
FROM
    animals
WHERE
    neutured = true;

SELECT
    *
FROM
    animals
WHERE
    name != 'Gabumon';

SELECT
    *
FROM
    animals
WHERE
    weight_kg <= 10.4
    AND weight_kg <= 17.3;

-- Begin a transaction
BEGIN;

-- setting the species column to unspecified
UPDATE
    animals
SET
    species = 'unspecified';

-- Verify that change was made
SELECT
    *
FROM
    animals;

-- roll back the change
ROLLBACK;

-- verify that the species columns went back
SELECT
    *
FROM
    animals;

--  setting the species to digimon for animals with names ending in mon
UPDATE
    animals
SET
    species = 'digimon'
WHERE
    LOWER(name) LIKE '%mon';

-- setting species to pokemon for animals that don't have species already set
UPDATE
    animals
SET
    species = 'pokemon'
WHERE
    species IS NULL;

-- Verify that changes were made
SELECT
    *
FROM
    animals;

-- Commit the transaction
COMMIT;

-- Verify that changes persist after commit
SELECT
    *
FROM
    animals;

-- Inside a transactionModify animals table
BEGIN;

-- delete all records in the animals table
DELETE FROM
    animals;

-- then roll back the transaction
ROLLBACK;

-- verify if all records in the animals table still exists
SELECT
    *
FROM
    animals;

-- Inside a transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022.
DELETE FROM
    animals
WHERE
    birth_date > '2022-01-01';

-- Create a savepoint for the transaction.
SAVEPOINT first;

-- Update all animals' weight to be their weight multiplied by -1
UPDATE
    animals
SET
    weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK;

-- Update all animals' weights that are negative to be multiplied by -1
UPDATE
    animals
SET
    weight = weight * -1
WHERE
    weight < 0;

-- Commit transaction
COMMIT;

-- How many animals are there?
SELECT
    COUNT(*)
FROM
    animals;

-- How many animals have never tried to escape?
SELECT
    COUNT(*)
FROM
    animals
WHERE
    escape_attempts = 0;

-- What is the average weight of animals?
SELECT
    AVG(weight_kg)
FROM
    animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT
    neutered,
    SUM(
        CASE
            WHEN escape_attempts > 0 THEN 1
            ELSE 0
        END
    ) AS escapes
FROM
    animals
GROUP BY
    neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT
    species,
    MIN(weight_kg) AS min_weight,
    MAX(weight_kg) AS max_weight
FROM
    animals
GROUP BY
    species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT
    species,
    AVG(escape_attempts) AS avg_escapes
FROM
    animals
WHERE
    date_of_birth BETWEEN '1990-01-01'
    AND '2000-12-31'
GROUP BY
    species;

-----------------------------------------------------------------------
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * ---------------------------------------------------------------------
-- What animals belong to Melody Pond?
SELECT
    owners.full_name AS owner,
    animals.name AS animal
FROM
    animals
    JOIN owners ON animals.owner_id = owners.id
WHERE
    owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT
    animals.name AS animal_name,
    species.name AS species_name
FROM
    animals
    JOIN species ON animals.species_id = species.id
WHERE
    species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT
    owners.full_name AS owner,
    animals.name AS animal
FROM
    owners
    LEFT JOIN animals ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT
    species.name AS species,
    COUNT(animals.id) AS count
FROM
    species
    LEFT JOIN animals ON species.id = animals.species_id
GROUP BY
    species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name AS animal, species.name AS species
FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name AS animal, animals.escape_attempts
FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts <= 0;

-- Who owns the most animals?
SELECT owners.full_name AS owner, COUNT(animals.id) AS count
FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.id, owners.full_name
ORDER BY count DESC
LIMIT 1;
