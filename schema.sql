/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id SERIAL PRIMARY KEY, 
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
);

-- add species column to animals
ALTER TABLE animals
ADD COLUMN species TEXT;

-- owners table 
--@block
CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INT
);

-- species table
--@block
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name TEXT
);

-- remove species column
--@block
ALTER TABLE animals DROP COLUMN species;


-- add species_id column
--@block
ALTER TABLE animals ADD COLUMN species_id INT;

--@block
ALTER TABLE animals 
ADD CONSTRAINT species_fk
FOREIGN KEY(species_id) 
REFERENCES species(id);

--@block
ALTER TABLE animals ADD COLUMN owner_id INT;

--@block
ALTER TABLE animals 
ADD CONSTRAINT owners_fk
FOREIGN KEY(owner_id) 
REFERENCES owners(id); 