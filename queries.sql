/*Queries that provide answers to the questions from all projects.*/
SELECT * FROM animals WHERE name::text LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered= TRUE AND escape_attempts < 3;
SELECT date_of_birth from animals WHERE name='Agumon' OR name= 'Pikachu';
SELECT name, escape_attempts from animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered= TRUE;
SELECT * FROM animals WHERE name NOT LIKE '%Gabumon%';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- set species column to unspecified
-- verify changes and roll back the change
-- verify that species went back to previous state

BEGIN TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- set species column to 'digimon'
-- for all animals ending with 'mon'
-- set species column to pokemon for all animals with no species set
-- verify changes and commit transaction
-- verify changes persist

BEGIN TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- delete all records in animals table
-- roll back
-- verify records exist

BEGIN TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;


-- delete all animals born after '2022-01-01
-- add save point'
-- multiply animal by -1
-- roll back to save point
-- multiply negative animals by -1

BEGIN TRANSACTION;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT save_point1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO save_point1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- how many animals are there?
SELECT COUNT(*) FROM animals;

-- how many animals never tried to escape?
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

-- whats the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- who escapes the most, neutered or not neutered animals?\
SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

-- what is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) 
FROM animals GROUP BY species;

-- what is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) 
FROM animals WHERE date_of_birth BETWEEN 
'1990-01-01' AND '2000-12-31' GROUP BY species;


--@block
-- what animals belong to Melody Pond?
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';



--@block
-- list all animals that are pokemon.
SELECT * FROM animals JOIN species ON 
animals.species_id = species.id 
WHERE species.name = 'Pokemon';


-- list all owners and their animals, 
--include those that don't own any animal.
--@block
SELECT * FROM owners LEFT JOIN animals 
ON owners.id = animals.owner_id;


-- how many animals are there per species?
--@block
SELECT species.name, COUNT(*) FROM species 
JOIN animals ON species.id = animals.species_id 
GROUP BY species.name;

-- list all digimon owned by jennifer.
--@block
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Jennifer Orwell' 
AND animals.species_id = 2;


-- list all animals owned by Dean Winchester that haven't tried to escape.
--@block
SELECT * FROM animals JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' 
AND animals.escape_attempts = 0;

-- who owns the most animals?
--@block
SELECT owners.full_name, COUNT(animals.owner_id) FROM owners LEFT JOIN animals ON owners.id = animals.owner_id GROUP BY owners.full_name ORDER BY COUNT(animals.owner_id) DESC LIMIT 1;