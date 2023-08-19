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