/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id SERIAL PRIMARY KEY, 
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL
);

-- add species column to animals
ALTER TABLE animals
ADD COLUMN species TEXT;

-- owners table 
CREATE TABLE owners(
    id SERIAL PRIMARY KEY,
    full_name TEXT,
    age INT
);

-- species table
CREATE TABLE species(
    id SERIAL PRIMARY KEY,
    name TEXT
);

ALTER TABLE animals DROP COLUMN species;


ALTER TABLE animals ADD COLUMN species_id INT;

ALTER TABLE animals 
ADD CONSTRAINT species_fk
FOREIGN KEY(species_id) 
REFERENCES species(id);


ALTER TABLE animals ADD COLUMN owner_id INT;

ALTER TABLE animals 
ADD CONSTRAINT owners_fk
FOREIGN KEY(owner_id) 
REFERENCES owners(id); 

-- vets table N 

    


CREATE TABLE vets (
    id SERIAL PRIMARY KEY,
    name TEXT,
    age INT,
    date_of_graduation DATE
);

-- specializations join table
CREATE TABLE specializations (
    species_id INT REFERENCES species(id),
    vet_id INT REFERENCES vets(id)
);

-- visits join table
CREATE TABLE visits (
    animals_id INT REFERENCES animals(id),
    vet_id INT REFERENCES vets(id),
    date_of_visit DATE
);

-- fix animals id of visits
alter table visits
rename animals_id to animal_id;

-- add email column to owners table
alter table owners 
add column email varchar(120);


-- add indexes for the visits 
-- and owners table
--@block
CREATE INDEX animals_id_asc ON visits(animal_id ASC);
CREATE INDEX vet_id_asc ON visits(vet_id ASC);
CREATE INDEX email_asc ON owners(email ASC);