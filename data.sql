/* Populate database with sample data. */
INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Agumon', '2020-02-03', 10.23, true, 0);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Gabumon', '2018-11-15', 8, true, 2);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Pikachu', '2021-01-07', 15.04, false, 1);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Devimon', '2017-05-12', 11, true, 5);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Charmander', '2020-02-08', -11, false, 0);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Plantmon', '2021-11-15', -5.7, true, 2);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Squirtle', '1993-04-02', -12.13, false, 3);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Angemon', '2005-06-12', -45, true, 1);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Boarmon', '2005-06-07', 20.4, true, 7);

INSERT INTO
    animals (
        name,
        date_of_birth,
        weight_kg,
        neutured,
        escape_attempts
    )
VALUES
    ('Blossom', '1998-10-13', 22, true, 4);

-- Insert the following data into the owners table:
-- Sam Smith 34 years old.
-- Jennifer Orwell 19 years old.
-- Bob 45 years old.
-- Melody Pond 77 years old.
-- Dean Winchester 14 years old.
-- Jodie Whittaker 38 years old
INSERT INTO
    owners (full_name, age)
VALUES
    ('Sam Smith', 34);

INSERT INTO
    owners (full_name, age)
VALUES
    ('Jennifer Orwell', 19);

INSERT INTO
    owners (full_name, age)
VALUES
    ('Bob', 45);

INSERT INTO
    owners (full_name, age)
VALUES
    ('Melody Pond', 77);

INSERT INTO
    owners (full_name, age)
VALUES
    ('Dean Winchester', 14);

INSERT INTO
    owners (full_name, age)
VALUES
    ('Jodie Whittaker', 38);

-- Insert the following data into the species table:
-- Pokemon
-- Digimon
INSERT INTO
    species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Modify your inserted animals so it includes the species_id value:
-- If the name ends in "mon" it will be Digimon
-- All other animals are Pokemon
UPDATE
    animals
SET
    species_id = (
        SELECT
            id
        FROM
            species
        WHERE
            name = 'Digimon'
    )
WHERE
    Lower(name) LIKE '%mon';

UPDATE
    animals
SET
    species_id = (
        SELECT
            id
        FROM
            species
        WHERE
            name = 'Pokemon'
    )
WHERE
    species_id IS NULL;

-- Modify your inserted animals to include owner information (owner_id):
-- Sam Smith owns Agumon.
-- Jennifer Orwell owns Gabumon and Pikachu.
-- Bob owns Devimon and Plantmon.
-- Melody Pond owns Charmander, Squirtle, and Blossom.
-- Dean Winchester owns Angemon and Boarmon.
UPDATE
    animals
SET
    owner_id = (
        CASE
            WHEN name = 'Agumon' THEN (
                SELECT
                    id
                FROM
                    owners
                WHERE
                    full_name = 'Sam Smith'
            )
            WHEN name IN ('Gabumon', 'Pikachu') THEN (
                SELECT
                    id
                FROM
                    owners
                WHERE
                    full_name = 'Jennifer Orwell'
            )
            WHEN name IN ('Devimon', 'Plantmon') THEN (
                SELECT
                    id
                FROM
                    owners
                WHERE
                    full_name = 'Bob'
            )
            WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (
                SELECT
                    id
                FROM
                    owners
                WHERE
                    full_name = 'Melody Pond'
            )
            WHEN name IN ('Angemon', 'Boarmon') THEN (
                SELECT
                    id
                FROM
                    owners
                WHERE
                    full_name = 'Dean Winchester'
            )
        END
    );

---------------------------------------------------------------
--------------------------------------------------------------
INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23');

INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('Maisy Smith', 26, '2019-01-17');

INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('Stephanie Mendez', 64, '1981-05-04');

INSERT INTO
    vets (name, age, date_of_graduation)
VALUES
    ('Jack Harkness', 38, '2008-06-08');

------------------------------------------------------------------
------------------------------------------------------------------
INSERT INTO
    specializations (vet_id, species_id)
VALUES
    (
        (
            SELECT
                id
            FROM
                vets
            WHERE
                name = 'William Tatcher'
        ),
        (
            SELECT
                id
            FROM
                species
            WHERE
                name = 'Pokemon'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                vets
            WHERE
                name = 'Stephanie Mendez'
        ),
        (
            SELECT
                id
            FROM
                species
            WHERE
                name = 'Digimon'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                vets
            WHERE
                name = 'Stephanie Mendez'
        ),
        (
            SELECT
                id
            FROM
                species
            WHERE
                name = 'Pokemon'
        )
    ),
    (
        (
            SELECT
                id
            FROM
                vets
            WHERE
                name = 'Jack Harkness'
        ),
        (
            SELECT
                id
            FROM
                species
            WHERE
                name = 'Digimon'
        )
    );