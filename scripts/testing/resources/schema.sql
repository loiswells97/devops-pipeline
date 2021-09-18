CREATE SCHEMA IF NOT EXISTS SSOSS_CircusSkill;
USE SSOSS_CircusSkill;

DROP TABLE IF EXISTS `ActivityLog`;
DROP TABLE IF EXISTS `ActivityOutputs`;
DROP TABLE IF EXISTS `FrameData`;
DROP TABLE IF EXISTS `ActivityData`;
DROP TABLE IF EXISTS `Activity`;
DROP TABLE IF EXISTS `ServiceProvider`;
DROP TABLE IF EXISTS `User`;

CREATE TABLE IF NOT EXISTS `ServiceProvider` (
  `ID_code`		INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name`	TEXT NOT NULL,
  `email`	VARCHAR(320),
  `telephone`	TEXT NOT NULL,
  `address`    TEXT NOT NULL,
  `postCode`    TEXT NOT NULL,
  `companiesHouse`    INTEGER NOT NULL
);

-- DROP TABLE IF EXISTS `Activity`;
CREATE TABLE IF NOT EXISTS `Activity` (
  `Date`		    DATE NOT NULL,
  `providerID`	INTEGER NOT NULL,
  `activityID`	INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `location`    TEXT NOT NULL,
  `keywords`    TEXT NOT NULL,
  `description` TEXT NOT NULL,
  FOREIGN KEY(`providerID`) REFERENCES `ServiceProvider`(`ID_code`)

);

-- DROP TABLE IF EXISTS `User`;
CREATE TABLE IF NOT EXISTS `User` (
`userID` INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
`firstName` TEXT NOT NULL,
`lastName` TEXT NOT NULL,
`dateOfBirth` DATE NOT NULL,
`email` TEXT NOT NULL,
`telephone` TEXT NOT NULL,
`address` TEXT NOT NULL,
`postCode` TEXT NOT NULL
);

-- DROP TABLE IF EXISTS `ActivityData`;
CREATE TABLE IF NOT EXISTS `ActivityData` (
`activityID` INTEGER NOT NULL,
`userID` INTEGER NOT NULL,
`metricNum` INTEGER NOT NULL,
`metric` TEXT NOT NULL,
FOREIGN KEY(`activityID`) REFERENCES `Activity`(`activityID`),
FOREIGN KEY(`userID`) REFERENCES `User`(`userID`)
);

-- DROP TABLE IF EXISTS `FrameData`;
CREATE TABLE IF NOT EXISTS `FrameData` (
`name` TEXT NOT NULL,
`providerID` INTEGER NOT NULL,
`metricNum` INTEGER NOT NULL,
`metric` TEXT NOT NULL,
`inputType` INTEGER NOT NULL, /* 1= Number, 2= Text*/
`sustainabilityGoals` TEXT,
FOREIGN KEY(`providerID`) REFERENCES `ServiceProvider`(`ID_code`)
);

-- DROP TABLE IF EXISTS `ActivityOutputs`;
CREATE TABLE IF NOT EXISTS `ActivityOutputs` (
`ID` INTEGER NOT NULL,
`activityID` INTEGER NOT NULL,
`metric` TEXT NOT NULL,
FOREIGN KEY(`activityID`) REFERENCES `Activity`(`activityID`)
);

-- DROP TABLE IF EXISTS `ActivityLog`;
CREATE TABLE IF NOT EXISTS `ActivityLog` (
`activityID` INTEGER NOT NULL,
`userID` INTEGER NOT NULL,
FOREIGN KEY(`activityID`) REFERENCES `Activity`(`activityID`),
FOREIGN KEY(`userID`) REFERENCES `User`(`userID`)
);