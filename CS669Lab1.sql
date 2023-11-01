CREATE TABLE Vacation(
VacationID DECIMAL(12) PRIMARY KEY,
Location VARCHAR(64) NOT NULL,
Description VARCHAR(1024) NULL,
StartedOn DATE NOT NULL,
EndedOn DATE NOT NULL
);

INSERT INTO Vacation(VacationId, Location, Description, StartedOn, EndedOn)
VALUES(1, 'Costa Rica', 'Relaxing Hot Springs', '2019-01-13', '2019-01-21');

INSERT INTO Vacation(VacationId, Location, Description, StartedOn, EndedOn)
VALUES(2, 'Bora Bora', 'Exciting Snorkeling', '2019-03-05', '2019-03-15');

INSERT INTO Vacation(VacationId, Location, Description, StartedOn, EndedOn)
VALUES(3, 'Jamaica', NULL, '2018-12-10', '2018-12-28');

DELETE FROM Vacation
WHERE VacationID IS NULL;

SELECT *
FROM Vacation;

INSERT INTO Vacation(VacationId, Location, Description, StartedOn, EndedOn)
VALUES(4, 'Netherlands', 'Experience the Netherlands No Other Way', '2020-01-01', '2020-01-10');

SELECT Location, Description
FROM Vacation
WHERE VacationId = 2;

UPDATE Vacation
SET Description = 'Aquatic Wonders'
WHERE VacationId = 3;

SELECT *
FROM Vacation;

UPDATE Vacation
SET Description = NULL
WHERE VacationId = 3;

SELECT *
FROM Vacation;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM Vacation
WHERE StartedOn > '2019-06-01';

SELECT *
FROM Vacation;
SET SQL_SAFE_UPDATES = 1;