-- A crime has taken place and the detective needs your help. 
-- The detective gave you the crime scene report, but you somehow lost it. 
-- You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 and that it took place in SQL City.

-- 1. How many people are in this database?
SELECT count(*)
FROM person;
-- Answer: 10011

-- 2. What do we know about those people?
SELECT * FROM person LIMIT 10;
-- Answer: id, name, license id, address nr, address street name and ssn

-- 3. What are the possible type of crimes?
SELECT DISTINCT type FROM crime_scene_report;
-- Answer: murder, theft, robbery, fraud, arson, bribery, assault, smuggling, blackmail

-- 4. Can you find the description of the murder?
SELECT * FROM crime_scene_report 
WHERE type = 'murder' 
AND city = 'SQL City';
-- Answer: there has only been one murder on Jan.15, 2018. The description is: 
-- Security footage shows that there were 2 witnesses. 
-- The first witness lives at the last house on "Northwestern Dr". 
-- The second witness, named Annabel, lives somewhere on "Franklin Ave".

-- 5. Can you find the peronsal details of the first witness?
SELECT * FROM person 
WHERE address_street_name = 'Northwestern Dr' 
ORDER BY address_number DESC LIMIT 1;
-- Answer: Morty Schapiro, address: Northwester Dr 4919, id 14887

-- 6. Can you find the personal details of the second witness?
SELECT * FROM person 
WHERE address_street_name = 'Franklin Ave' and name like 'Annabel%'
-- Answer: Annabel Miller, Franklin Ave 103, id 16371

-- 6. Show the transcripts of the two witnesses
SELECT name, address_street_name, address_number, transcript
FROM person p 
JOIN interview i ON p.id = i.person_id
WHERE p.id = 14887 OR p.id = 16371 
-- Transcript Morty Schapiro: I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
-- Transcript Annabel Miller: I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.

-- The last queries to find the killer:
SELECT dl.plate_number, p.name, g.id
FROM drivers_license dl
JOIN person p ON dl.id = p.license_id
JOIN get_fit_now_member g ON p.id = g.person_id
WHERE g.id LIKE '48Z%' AND dl.plate_number like '%H42W%'
-- Answer: Jeremy Bowers with gym member id "48Z55" and license plate number "0H42W2" is the killer.
