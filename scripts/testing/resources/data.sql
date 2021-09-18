INSERT INTO `ServiceProvider` (`ID_code`, `name`, `email`, `telephone`, `address`, `postCode`, `companiesHouse`) VALUES
('1', 'Circus Skills UK', 'nathan@example.net', '01234567890', '1 Example Street', 'EX49 1OL', '48972942'),
('2', 'Save Our Planet', 'george@example.net', '09876543210', '1 Imaginary Street', 'CB3 9ET', '29765289'),
('3', 'Help the Homeless', 'thomasjones@example.net', '03865234789', '1 Made-Up Street', 'HG4 9LK', '25629769'),
('4', 'The Library Project', 'jamesowen@example.net', '04857918367', '1 Random Street', 'DP76 8VR', '24672976');

INSERT INTO Activity (Date, providerID, activityID, location, keywords, description) VALUES
('2021-8-27', '1', '1', 'Cardiff', 'teenagers, extra-curricular, outdoors', 'Tightrope Walking'),
('2021-9-27', '1', '2', 'Newport', 'teenagers, extra-curricular, skills', 'Juggling'),
('2020-10-27', '1', '3', 'Cwmbran', 'teenagers, extra-curricular, outdoors', 'Tightrope Walking'),
('2020-10-26', '1', '4', 'Cardiff', 'teenagers, extra-curricular, skills', 'Juggling'),
('2020-10-25', '1', '5', 'Swansea', 'teenagers, extra-curricular, acrobatics', 'Cloud Swing'),
('2021-10-24', '2', '6', 'Bangor', 'environmental, trees, carbon capture, reforestation', 'Tree Planting'),
('2021-10-23', '2', '7', 'Llandudno', 'environmental, trees, carbon capture, reforestation', 'Tree Planting'),
('2020-10-22', '2', '8', 'Wrexham', 'environmental, litter, outdoors', 'Litter Picking'),
('2020-10-21', '2', '9', 'Llandudno', 'environmental, litter, outdoors', 'Litter Picking'),
('2020-10-27', '2', '10', 'Rhyl', 'environmental, litter, recycling','Rubbish Sorting'),
('2021-1-2', '3', '11', 'Cardiff', 'fundraising, sponsored','Great Big Fundraiser'),
('2021-4-22', '3', '12', 'Swansea', 'food, homelessness, compassion','Soup Kitchen'),
('2021-9-27', '3', '13', 'Newport', 'food, homelessness, compassion', 'Soup Kitchen'),
('2020-10-23', '3', '14', 'Port Talbot', 'clothes, homelessness, compassion', 'Clothing Distribution'),
('2020-10-22', '3', '15', 'Newport', 'food, homelessness, compassion', 'Clothing Distribution'),
('2020-10-21', '4', '16', 'New Quay', 'children, reading, education, inspirational', 'Story Time'),
('2021-9-27', '4', '17', 'Merthyr Tydfil', 'children, reading, education, inspirational','Story Time'),
('2021-6-27', '4', '18', 'Tenby', 'reading, donations, books','Book Collection'),
('2021-1-14', '4', '19', 'Newport', 'children, reading, education, inspirational','Story Time'),
('2020-11-13', '4', '20', 'Cwmbran', 'reading, donations, books','Book Distribution');

INSERT INTO `User` (`userID`, `firstName`, `lastName`, `dateOfBirth`, `email`, `telephone`, `address`, `postCode`) VALUES
('1', 'Joe', 'Bloggs', '2001-1-1', 'joebloggs@example.net', '01234567890', '27 Example Street', 'EX49 1OL'),
('2', 'John', 'Doe', '1995-12-02', 'johndoe@example.net', '09876543210', '24 Imaginary Street', 'CB3 9ET'),
('3', 'Thomas', 'Jones', '1989-05-19', 'thomasjones@example.net', '03865234789', '6 Made-Up Street', 'HG4 9LK'),
('4', 'James', 'Owens', '1972-03-31', 'jamesowen@example.net', '04857918367', '12 Random Street', 'DP76 8VR'),
('5', 'Jacob', 'Josephs', '1992-05-16', 'jacobjosephs@example.net', '02567947156', '824 Unknown Street', 'SD5 2RW'),
('6', 'Hannah', 'Bryan', '2001-01-01', 'hannahbryan@example.net', '07284018583', '54 Example Street', 'EX49 1OL'),
('7', 'Tabitha', 'McCallum', '1997-11-02', 'tabithamccallum@example.net', '07820317654', '71 Imaginary Street', 'CB3 9ET'),
('8', 'Penny', 'Burden', '1974-05-13', 'pennyburden@example.net', '01786904009', '7 Made-Up Street', 'HG4 9LK'),
('9', 'Catherine', 'Thompson', '1955-03-12', 'catherinethompson@example.net', '02345167290', '1 Random Street', 'DP76 8VR'),
('10', 'Mark', 'Smith', '1992-12-21', 'marksmith@example.net', '05164786564', '6 Unknown Street', 'SD5 2RW'),
('11', 'Joe', 'Jenkins', '2001-02-03', 'joejenkins@example.net', '07817877906', '25 Example Street', 'EX49 1OL'),
('12', 'James', 'Doe', '1995-11-16', 'jamesdoe@example.net', '05167589088', '37 Imaginary Street', 'CB3 9ET'),
('13', 'Thomas', 'Oliver', '1989-07-03', 'thomasoliver@example.net', '08899223456', '16 Made-Up Street', 'HG4 9LK'),
('14', 'Toby', 'Owens', '1998-03-14', 'tobyowen@example.net', '01234321234', '72 Random Street', 'DP76 8VR'),
('15', 'Julie', 'Smith', '1992-11-20', 'juliesmith@example.net', '07869091785', '152 Unknown Street', 'SD5 2RW'),
('16', 'Nathan', 'Bloggs', '2000-12-12', 'nathanbloggs@example.net', '01456785345', '14 Example Street', 'EX49 1OL'),
('17', 'Ellie', 'Stephens', '2003-04-09', 'elliestephens@example.net', '02564098908', '73 Imaginary Street', 'CB3 9ET'),
('18', 'Matthew', 'Taylor', '1991-07-18', 'matthewtaylor@example.net', '06793675934', '7 Made-Up Street', 'HG4 9LK'),
('19', 'Ruth', 'Jacobs', '1976-09-10', 'ruthjacobs@example.net', '09826507890', '87 Random Street', 'DP76 8VR'),
('20', 'David', 'Andrews', '1967-12-28', 'davidandrews@example.net', '01657903657', '112 Unknown Street', 'SD5 2RW');


INSERT INTO `ActivityData` (`activityID`, `userID`, `metricNum`, `metric`) VALUES
('3', '1', '1', '6'),('3', '1', '2', '4500'),('3', '1', '3', '9'),('3', '3', '1', '9'),('3', '3', '2', '12000'),('3', '3', '3', '16'),
('4', '6', '1', '9'),('4', '6', '2', '17'),('4', '8', '1', '4'),('4', '8', '2', '3'),
('5', '9', '1', '6'),('5', '9', '2', '7'),('5', '10', '1', '9'),('5', '10', '2', '14'),
('8', '17', '1', '12'),('8', '17', '2', '6'),('8', '17', '3', '2'),('8', '17', '4', '5'),('8', '17', '5', '3'),('8', '17', '6', '4900'),
('8', '18', '1', '10'),('8', '18', '2', '7'),('8', '18', '3', '3'),('8', '18', '4', '4'),('8', '18', '5', '3'),('8', '18', '6', '2800'),
('9', '17', '1', '9'),('9', '17', '2', '8'),('9', '17', '3', '1'),('9', '17', '4', '1'),('9', '17', '5', '2'),('9', '17', '6', '3500'),
('9', '18', '1', '6'),('9', '18', '2', '7'),('9', '18', '3', '3'),('9', '18', '4', '2'),('9', '18', '5', '3'),('9', '18', '6', '1000'),
('10', '13', '1', '8'),('10', '13', '2', '6'),('10', '13', '3', '2'),('10', '12', '1', '3'),('10', '12', '2', '2'),('10', '12', '3', '7'),
('11', '2', '1', '7'),('11', '2', '2', '200'),('11', '2', '3', '7'),('11', '3', '1', '4'),('11', '3', '2', '150'),('11', '3', '3', '2'),
('14', '8', '1', '7'),('14', '9', '1', '9'),('14', '10', '1', '3'),('14', '11', '1', '5'),('14', '12', '1', '3'),('14', '13', '1', '1'),
('15', '8', '1', '8'),('15', '9', '1', '3'),('15', '10', '1', '2'),
('16', '14', '1', '3'),('16', '14', '2', '6'),('16', '15', '1', '6'),('16', '15', '2', '12'),('16', '16', '1', '1'),('16', '16', '2', '3'),
('19', '14', '2', '3'),('19', '14', '2', '6'),('19', '15', '2', '2'),('19', '15', '2', '8'),
('20', '19', '1', '8'),('20', '19', '2', '5'),('20', '20', '1', '4'),('20', '20', '2', '12')
;

INSERT INTO `FrameData` (`name`, `providerID`, `metricNum`, `metric`, `inputType`, `sustainabilityGoals`) VALUES
('Tightrope Walking', '1', '1', 'Number of hours volunteered', '1', 'Quality Education, Reduced Inequality'),
('Tightrope Walking', '1', '2', 'Number of steps taken', '1', 'Good Health and Well-being'),
('Tightrope Walking', '1', '3', 'Number of children supervised', '1', 'Quality Education, Reduced Inequality'),

('Juggling', '1', '1', 'Number of hours volunteered', '1', 'Quality Education, Reduced Inequality'),
('Juggling', '1', '2', 'Number of children supervised', '1', 'Quality Education, Reduced Inequality'),

('Cloud Swing', '1', '1', 'Number of hours volunteered', '1', 'Quality Education, Reduced Inequality'),
('Cloud Swing', '1', '2', 'Number of children supervised', '1', 'Quality Education, Reduced Inequality'),

('Tree Planting', '2', '1', 'Number of hours volunteered', '1', 'Climate Action, Life on Land'),
('Tree Planting', '2', '2', 'Number of steps taken', '1', 'Good Health and Well-being'),
('Tree Planting', '2', '3', 'Number of trees planted', '1', 'Climate Action, Life on Land, Sustainable Cities and Communities'),
('Tree Planting', '2', '4', 'Species of trees planted', '2', 'Climate Action, Life on Land, Sustainable Cities and Communities'),

('Litter Picking', '2', '1', 'Number of hours volunteered', '1', 'Climate Action, Life on Land'),
('Litter Picking', '2', '2', 'Number of bin bags of litter collected', '1', 'Climate Action, Life on Land'),
('Litter Picking', '2', '3', 'Weight of plastic collected', '1', 'Climate Action, Life on Land'),
('Litter Picking', '2', '4', 'Weight of metal collected', '1', 'Climate Action, Life on Land'),
('Litter Picking', '2', '5', 'Weight of glass collected', '1', 'Climate Action, Life on Land'),
('Litter Picking', '2', '6', 'Number of steps taken', '1', 'Good Health and Well-being'),

('Rubbish Sorting', '2', '1', 'Number of hours spent sorting rubbish', '1', 'Climate Action, Life on Land'),
('Rubbish Sorting', '2', '2', 'Weight of recyclables sorted', '1', 'Climate Action, Life on Land'),
('Rubbish Sorting', '2', '3', 'Weight of non-recyclables sorted', '1', 'Climate Action, Life on Land'),

('Great Big Fundraiser', '3', '1', 'Number of hours volunteered', '1', 'Climate Action, Life on Land'),
('Great Big Fundraiser', '3', '2', 'Amount of money made (£)', '1', 'Good Health and Well-being'),
('Great Big Fundraiser', '3', '3', 'Activity supervised', '1', 'Climate Action, Life on Land, Sustainable Cities and Communities'),

('Soup Kitchen', '3', '1', 'Number of hours volunteered', '1', 'Good Health and Well-being, Sustainable Cities and Communities'),
('Soup Kitchen', '3', '2', 'Number of attendees', '1', 'Good Health and Well-being, Zero Hunger'),

('Clothing Distribution', '3', '1', 'Number of hours volunteered', '1', 'Reduced Inequality, Sustainable Cities and Communities'),

('Story Time', '4', '1', 'Number of hours volunteered', '1', 'Good Health and Well-being, Sustainable Cities and Communities'),
('Story Time', '4', '2', 'Number of children', '1', 'Reduced Inequality, Sustainable Cities and Communities, Quality Education'),

('Book Collection', '4', '1', 'Number of books collected', '1', 'Sustainable Cities and Communities, Responsible Consumption and Production, Partnerships to achieve the Goal'),
('Book Collection', '4', '2', 'Number of hours volunteered', '1', 'Decent Work and Economic Growth'),
('Book Collection', '4', '3', 'Number of donors', '1', 'Sustainable Cities and Communities'),

('Book Distribution', '4', '1', 'Number of books distributed', '1', 'Sustainable Cities and Communities, Quality Education'),
('Book Distribution', '4', '2', 'Number of hours volunteered', '1', 'Good Health and Well-being');

INSERT INTO `ActivityLog`(`activityID`, `userID`) VALUES
(1,1),(1,2),

(2,5),(2,7),

(3,1),(3,3),

(4,6),(4,8),

(5,9),(5,10),

(6,12),(6,15),

(7,12),(7,15),

(8,17),(8,18),

(9,17),(9,18),

(10,13),(10,12),

(11,3),(11,2),

(12,5),(12,6),(12,7),

(13,5),(13,6),(13,7),

(14,8),(14,9),(14,10),(14,11),(14,12),(14,13),

(15,8),(15,9),(15,10),

(16,14),(16,15),(16,16),

(17,14),(17,15),

(18,17),(18,17),

(19,14),(19,15),

(20,19),(20,20)
;

