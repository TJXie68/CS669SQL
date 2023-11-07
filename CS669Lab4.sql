CREATE TABLE Person(
person_id DECIMAL(12) NOT NULL PRIMARY KEY,
first_name VARCHAR(32) NOT NULL,
last_name VARCHAR(32) NOT NULL,
username VARCHAR(20) NOT NULL);

CREATE TABLE Post(
post_id DECIMAL(12) NOT NULL PRIMARY KEY,
person_id DECIMAL(12) NOT NULL,
content VARCHAR(255) NOT NULL,
created_on DATE NOT NULL,
summary VARCHAR(15) NOT NULL,
FOREIGN KEY(person_id) REFERENCES Person(person_id));

CREATE TABLE Likes(
likes_id DECIMAL(12) NOT NULL PRIMARY KEY,
person_id DECIMAL(12) NOT NULL,
post_id DECIMAL(12) NOT NULL,
liked_on DATE,
FOREIGN KEY(person_id) REFERENCES Person(person_id),
FOREIGN KEY(post_id) REFERENCES Post(post_id));

INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (1, 'Emily', 'Johnson', 'EmiGamer');
INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (2, 'Marcus', 'Roderiguez', 'MaverickMarc');
INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (3, 'Sarah', 'Davis', 'SunnySarah');
INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (4, 'Jason', 'Thompson', 'TechWizardJay');
INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (5, 'Olivia', 'White', 'LivinStyle');
INSERT INTO Person(person_id, first_name, last_name, username)
VALUES (6, 'Michael', 'Lee', 'TravelMike');

INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (101, 1, 
'Just scored a victory royale in Fortnite! #GamerLife #VictoryRoyale',
'2023-10-17',
'Just scored ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (201, 2, 
'On top of the world! Just reached the summit of Mount Everest. #AdventureTime #BucketList',
'2023-10-22',
'On top of th...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (301, 3, 
'Enjoying a peaceful day at the beach. #BeachLife #Relaxation',
'2023-09-29',
'Enjoying a p...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (401, 4, 
'Geeking out over the latest tech gadgets at CES 2023. #TechGeek #CES2023',
'2023-10-21',
'Geeking out ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (501, 5, 
'New fashion haul from Milan! Can\'t wait to rock these looks. #Fashionista #MilanFashionWeek',
'2023-10-07',
'New fashion ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (601, 6, 
'Exploring the ancient ruins of Machu Picchu. This place is truly magical. #TravelGoals #MachuPicchu',
'2023-09-12',
'Exploring th...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (602, 6, 
'Backpacking through Europe and making memories one city at a time. #Wanderlust #EuropeAdventures',
'2023-09-20',
'Backpacking ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (603, 6, 
'Chasing the Northern Lights in Norway! Witnessed an incredible light show tonight. #AuroraBorealis #BucketList',
'2023-09-28',
'Chasing the ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (604, 4, 
'Scuba diving in the Great Barrier Reef. The underwater world is breathtaking. #UnderTheSea #GreatBarrierReef',
'2023-10-11',
'Scuba diving...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (605, 6, 
'Enjoying a cup of traditional Japanese matcha in Kyoto. Embracing the culture and flavors. #TravelDiaries #JapanAdventures',
'2023-10-29',
'Enjoying a c...');

INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(2001, 2, 602, '2023-09-22');
INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(3001, 3, 604, '2023-10-11');
INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(3002, 3, 605, '2023-10-30');
INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(4001, 4, 101, '2023-10-20');
INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(5001, 5, 301, '2023-09-30');

DELIMITER //
CREATE PROCEDURE add_zana_sage()
BEGIN
	INSERT INTO Person(person_id, first_name, last_name, username)
    VALUES(7, 'Zana', 'Sage', 'ZanaS');
END //
DELIMITER ;

CALL add_zana_sage;

DELIMITER //
CREATE PROCEDURE add_person(
	person_id_arg DECIMAL(12),
    first_name_arg VARCHAR(32),
    last_name_arg VARCHAR(32),
    username_arg VARCHAR(20)
)
BEGIN
	INSERT INTO Person(person_id, first_name, last_name, username)
    VALUES(person_id_arg, first_name_arg, last_name_arg, username_arg);
END //
DELIMITER ;

CALL add_person(8, 'Samantha', 'Mitchell', 'SamiExplorer');

DELIMITER //
CREATE PROCEDURE add_post(
	post_id_arg DECIMAL(12),
	person_id_arg DECIMAL(12),
	content_arg VARCHAR(255),
	created_on_arg DATE
)
BEGIN
	DECLARE summary_arg VARCHAR(15);
    SET summary_arg = CONCAT(SUBSTRING(content_arg, 1, 12), '...');
    INSERT INTO Post(post_id, person_id, content, created_on, summary)
    VALUES(post_id_arg, person_id_arg, content_arg, created_on_arg, summary_arg);
END //
DELIMITER ;

CALL add_post(801,8,
'Just booked my next adventure to Bali! Can\'t wait to explore the beautiful beaches,
 temples, and immerse myself in the local culture. Any travel tips for Bali? 🗺️ #Wanderlust #BaliBound',
'2023-10-19');

DELIMITER //
CREATE PROCEDURE add_like(
	likes_id_arg DECIMAL(12),
    post_id_arg DECIMAL(12),
    username_arg VARCHAR(20),
	liked_on_arg DATE
)
BEGIN
	DECLARE person_id_arg DECIMAL(12);
    SELECT person_id INTO person_id_arg
    FROM Person
    WHERE username = username_arg;
    INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
    VALUES(likes_id_arg, person_id_arg, post_id_arg, liked_on_arg);
END //
DELIMITER ;

CALL add_like(8001, 604, 'SamiExplorer', '2023-10-12');
SELECT * FROM Likes;

DELIMITER //
CREATE PROCEDURE delete_person(
	username_arg VARCHAR(20)
)
BEGIN
	DECLARE person_id_arg DECIMAL(12);
    SELECT person_id INTO person_id_arg
    FROM Person
    WHERE username = username_arg;
    DELETE FROM Likes
    WHERE person_id = person_id_arg;
    DELETE FROM Post
    WHERE person_id = person_id_arg;
    DELETE FROM Person
    WHERE person_id = person_id_arg;
END //
DELIMITER ;

CALL delete_person('LivinStyle');
SELECT * FROM Person;
SELECT * FROM Post;
SELECT * FROM Likes;

-- DELIMITER //
-- CREATE TRIGGER summary_validate
-- 	BEFORE INSERT
--     ON Post
-- FOR EACH ROW
-- BEGIN
-- 	SET @summary_arg = (SELECT Post.summary FROM Post);
--     SET @content_arg = (SELECT Post.content FROM Post);
--     IF summary_arg != CONCAT(SUBSTRING(content_arg, 1, 12), '...')
--     THEN 
-- 		SIGNAL SQLSTATE '45000'
-- 		SET MESSAGE_TEXT = 'Insert does not have a valid summary value';
-- 	END IF;
-- END; //
-- DELIMITER ;

DROP TRIGGER summary_validate;
DROP TRIGGER bad_summary;


DELIMITER //
CREATE TRIGGER bad_summary 
	BEFORE INSERT 
    ON Post
FOR EACH ROW
BEGIN
	IF new.summary != CONCAT(SUBSTR(new.content,1,12), '...') 
    THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Insert does not have a valid summary value';
    END IF;
END; //
DELIMITER ;

INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (802,8,
'Sunset over the rice terraces in Ubud, Bali. Nature\'s masterpiece! #Ubud #BaliAdventures #SunsetMagic',
'2023-09-22',
'Sunset over ...');
INSERT INTO Post(post_id, person_id, content, created_on, summary)
VALUES (802,8,
'Sunset over the rice terraces in Ubud, Bali. Nature\'s masterpiece! #Ubud #BaliAdventures #SunsetMagic',
'2023-09-22',
'Sunset over');

SELECT * FROM Post;

DROP TRIGGER like_date;

DELIMITER //
CREATE TRIGGER like_date
	BEFORE INSERT 
    ON Likes
FOR EACH ROW
BEGIN
	DECLARE created_on_arg DATE;
	SELECT created_on INTO created_on_arg
    FROM Post
    WHERE post_id = new.post_id;
	IF new.liked_on < created_on_arg
    THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Invalid Date';
    END IF;
END; //
DELIMITER ;


-- DELIMITER //
-- CREATE TRIGGER like_date
-- 	BEFORE INSERT 
--     ON Likes
-- FOR EACH ROW
-- BEGIN
--     SET @created_on_arg = (SELECT Post.created_on FROM Post);
-- 	IF new.liked_on < created_on_arg
--     THEN
-- 		SIGNAL SQLSTATE '45000'
-- 		SET MESSAGE_TEXT = 'Invalid Date';
--     END IF;
-- END; //
-- DELIMITER ;

INSERT INTO Likes(likes_id, person_id, post_id, liked_on)
VALUES(8001, 8, 602, '2023-09-19');

CREATE TABLE post_content_history(
post_id DECIMAL(12) NOT NULL,
old_content VARCHAR(255) NOT NULL,
new_content VARCHAR(255) NOT NULL,
update_on DATE NOT NULL,
FOREIGN KEY(post_id) REFERENCES Post(post_id));

DELIMITER //
CREATE TRIGGER post_update
	BEFORE UPDATE
    ON Post
FOR EACH ROW
BEGIN
	IF old.content <> new.content
		THEN
		INSERT INTO post_content_history(post_id, old_content, new_content, update_on)
		VALUES (new.post_id, old.content, new.content, DATE(sysdate()));
    END IF;
END; //
DELIMITER ;

UPDATE Post
SET content = 'Enjoying a cup of traditional Japanese matcha in Tokyo. Embracing the culture and flavors. #TravelDiaries #JapanAdventures'
WHERE post_id = 605;

DROP TABLE post_content_history;
DROP TRIGGER post_update;
SELECT * FROM post_content_history;
SELECT *
FROM Post
WHERE post_id =605;