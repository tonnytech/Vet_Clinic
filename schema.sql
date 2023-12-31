/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name CHAR(255),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BIT,
    weight_kg DECIMAL(5, 2),
    PRIMARY KEY(id)
);

ALTER TABLE
    animals
ADD
    species VARCHAR(255);

-- Create a table named owners
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(256),
    age INT,
    PRIMARY KEY (id)
);

-- Create a table named species
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(250),
    PRIMARY KEY(id)
);

-- Modify animals table make sure that id is set as autoincremented PRIMARY KEY
ALTER TABLE
    animals
ALTER COLUMN
    id
ADD
    GENERATED ALWAYS AS IDENTITY;

-- Remove column species
ALTER TABLE
    animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE
    animals
ADD
    COLUMN species_id INT;

ALTER TABLE
    animals
ADD
    CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE
    animals
ADD
    COLUMN owner_id INT;

ALTER TABLE
    animals
ADD
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE
    animals
ADD
    COLUMN owner_id INT,
ADD
    CONSTRAINT fk_owner FOREIGN KEY (owner_id) REFERENCES owners(id);

-------------------------------------------------------------------------
--------------------------------------------------------------------------

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    date_of_graduation DATE
);


CREATE TABLE specializations (
    vet_id INT,
    species_id INT,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

-------------------------------------------------------------------------
-------------------------------------------------------------------------
