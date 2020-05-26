CREATE TABLE Musicians(
ssn CHAR(11),
name CHAR(100),
annualIncome REAL,
PRIMARY KEY (ssn));

CREATE TABLE Instruments(
instrID CHAR(11),
iname CHAR(100),
musickey CHAR(20),
PRIMARY KEY (instrID));

CREATE TABLE Plays(
ssn CHAR(11),
instrID CHAR(11),
PRIMARY KEY (ssn, instrID),
FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
FOREIGN KEY (instrID) REFERENCES Instruments(instrID));

CREATE TABLE AlbumProducer(
albumIdentifier CHAR(11),
ssn CHAR(11),
copyrightDate DATE,
speed REAL,
title CHAR(100),
PRIMARY KEY (albumIdentifier),
FOREIGN KEY (ssn) REFERENCES Musicians(ssn));

CREATE TABLE SongsAppears(
songID CHAR(11),
authorSSN CHAR(11),
title CHAR(100),
albumIdentifier CHAR(11),
PRIMARY KEY (songID),
FOREIGN KEY (albumIdentifier) REFERENCES AlbumProducer(albumIdentifier));

CREATE TABLE Place(
address CHAR(100),
otherInfo CHAR(100),
PRIMARY KEY (address));

CREATE TABLE Lives(
ssn CHAR(11),
address CHAR(100),
phone CHAR(10),
PRIMARY KEY (ssn, address),
FOREIGN KEY (ssn) REFERENCES Musicians(ssn),
FOREIGN KEY (address) REFERENCES Place(address));

CREATE TABLE Perform(
songID CHAR(11),
ssn CHAR(11),
PRIMARY KEY (songID, ssn),
FOREIGN KEY (songID) REFERENCES SongsAppears(songID),
FOREIGN KEY (ssn) REFERENCES Musicians(ssn));

/* ******** each table insert at least 2 tuples ******** */
INSERT
INTO Musicians(ssn, name, annualIncome)
VALUES(11111111111, 'George Lam', 0);

INSERT
INTO Musicians(ssn, name, annualIncome)
VALUES(22222222222, 'Eason Chan', 0);

INSERT
INTO Instruments(instrID, iname, musickey)
VALUES(11111111111, 'guitar', 'all');

INSERT
INTO Instruments(instrID, iname, musickey)
VALUES(22222222222, 'keyboard', 'all');

INSERT
INTO Plays(ssn, instrID)
VALUES(11111111111, 11111111111);

INSERT
INTO Plays(ssn, instrID)
VALUES(11111111111, 22222222222);

INSERT
INTO AlbumProducer(albumIdentifier, ssn, copyrightDate, speed, title)
VALUES(11111111111, 11111111111, '2010-11-01', 0, 'Lamusique');

INSERT
INTO AlbumProducer(albumIdentifier, ssn, copyrightDate, speed, title)
VALUES(22222222222, 11111111111, '2014-01-01', 0, 'Lamusic Original');

INSERT
INTO SongsAppears(songID, authorSSN, title, albumIdentifier)
VALUES(11111111111, 11111111111, 'Lonely Wont Leave Me Alone', 11111111111);

INSERT
INTO SongsAppears(songID, authorSSN, title, albumIdentifier)
VALUES(22222222222, 11111111111, 'Make My Day', 22222222222);

INSERT
INTO Place(address, otherInfo)
VALUES('somewhere in HK', 'NA');

INSERT
INTO Place(address, otherInfo)
VALUES('some other places in HK', 'NA');

INSERT
INTO Lives(ssn, address, phone)
VALUES(11111111111, 'somewhere in HK', 'NA');

INSERT
INTO Lives(ssn, address, phone)
VALUES(22222222222, 'some other places in HK', 'NA');

INSERT
INTO Perform(songID, ssn)
VALUES(11111111111, 11111111111);

INSERT
INTO Perform(songID, ssn)
VALUES(22222222222, 11111111111);