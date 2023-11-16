CREATE TABLE Account(
UserID DECIMAL(12) NOT NULL PRIMARY KEY,
AccountName VARCHAR(64) NOT NULL,
Weight DECIMAL(12),
Age DECIMAL(12),
Gender VARCHAR(64),
LastLogin TIMESTAMP NOT NULL, -- new
MembershipStartDate DATE NOT NULL, -- new
LanguagePerference VARCHAR(10) NOT NULL ); -- new


CREATE TABLE Date(
User_Date DECIMAL(32) PRIMARY KEY,
Date DECIMAL(12) NOT NULL);

CREATE TABLE Data(
User_Date DECIMAL(32),
UserID DECIMAL(12) NOT NULL,
Steps DECIMAL(12),
HeartRate DECIMAL(12),
SleepTime DECIMAL(12),
TotalDistance DECIMAL(12),
FOREIGN KEY(UserID) REFERENCES Account(UserID),
FOREIGN KEY(User_Date) REFERENCES Date(User_Date));

CREATE TABLE BMI(
BMI DECIMAL(12),
UserID DECIMAL(12) NOT NULL,
User_Date DECIMAL(32) NOT NULL,
FOREIGN KEY(UserID) REFERENCES Account(UserID),
FOREIGN KEY(User_Date) REFERENCES Date(User_Date));

CREATE TABLE Cal(
Calories DECIMAL(12),
Score DECIMAL(12),
Suggestion VARCHAR(255),
User_Date DECIMAL(32),
UserID DECIMAL(12),
PRIMARY KEY (UserID, User_Date),
FOREIGN KEY(UserID) REFERENCES Account(UserID),
FOREIGN KEY(User_Date) REFERENCES Date(User_Date));


CREATE TABLE V02MaxScore(
UserID DECIMAL(12) NOT NULL,
User_Date DECIMAL(32),
AccountName VARCHAR(64) NOT NULL,
VO2_Score DECIMAL(12),
FOREIGN KEY(UserID, User_Date) REFERENCES Cal(UserID, User_Date),
);


CREATE TABLE BMIScore(
UserID DECIMAL(12) NOT NULL,
User_Date DECIMAL(32),
BMI_Score DECIMAL(12),
FOREIGN KEY(UserID, User_Date) REFERENCES Cal(UserID, User_Date)
);

CREATE TABLE PurchaseAccount(
TrackingNumber VARCHAR(255) NOT NULL PRIMARY KEY, -- new
UserID DECIMAL(12) NOT NULL,
AccountName VARCHAR(64) NOT NULL,
BMI DECIMAL(12) NOT NULL,
Score DECIMAL(12) NOT NULL,
Suggestion VARCHAR(255) NOT NULL,
PurchaseDate DATE NOT NULL, -- new
FOREIGN KEY(UserID) REFERENCES Account(UserID)
);

CREATE TABLE FreeAccount(
UserID DECIMAL(12) NOT NULL,
AccountName VARCHAR(64) NOT NULL,
FOREIGN KEY(UserID) REFERENCES Account(UserID)
);