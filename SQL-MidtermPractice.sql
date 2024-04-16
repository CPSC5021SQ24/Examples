USE OrganizationalChart;

CREATE TABLE Positions(
	IDRole int NOT NULL,
	RoleName varchar(50) NOT NULL,
	IDArea int NOT NULL,
 CONSTRAINT PK_Positions PRIMARY KEY
	(
	IDRole
	)
);

CREATE TABLE Candidates(
	IDPerson int NOT NULL,
	IDRole int NOT NULL,
	Status int NOT NULL,
 CONSTRAINT PK_Candidates PRIMARY KEY
	(
	IDPerson,
	IDRole
	)
);

CREATE TABLE HiringManagers(
	IDPerson int NOT NULL,
	IDRole int NOT NULL,
 CONSTRAINT PK_HiringManager PRIMARY KEY 
	(
	IDPerson,
	IDRole
	)
);
CREATE TABLE InterviewTypes(
	IDType int NOT NULL,
	TypeName nchar(10) NULL,
 CONSTRAINT PK_InterviewTypes PRIMARY KEY
	(
	IDType
	)
);
CREATE TABLE Interviews(
	IDInterview int NOT NULL,
	IDRole int NOT NULL,
	IDCandidate int NOT NULL,
	Link varchar(255) NULL,
	Date date NULL,
	Time time(7) NULL,
	Duration int NULL,
	InterviewType int NULL,
 CONSTRAINT PK_Interviews PRIMARY KEY
	(
	IDInterview
	)
);
CREATE TABLE Interviewers(
	IDInterview int NOT NULL,
	IDInterviewer int NOT NULL,
 CONSTRAINT PK_Interviewers PRIMARY KEY
	(
	IDInterview,
	IDInterviewer
	)
);

-- This is not the basic SQL Script, but for reference, how we implement the foreign keys enforcement
ALTER TABLE Candidates ADD CONSTRAINT FK_Candidates_Persons FOREIGN KEY(IDPerson)
REFERENCES Persons (IDPersonnel);
ALTER TABLE Candidates ADD CONSTRAINT FK_Candidates_Positions FOREIGN KEY(IDRole)
REFERENCES Positions (IDRole);
ALTER TABLE HiringManagers ADD CONSTRAINT FK_HiringManager_Persons FOREIGN KEY(IDPerson)
REFERENCES Persons (IDPersonnel);
ALTER TABLE HiringManagers  ADD CONSTRAINT FK_HiringManager_Positions FOREIGN KEY(IDRole)
REFERENCES Positions (IDRole);
ALTER TABLE Interviewers ADD CONSTRAINT FK_Interviewers_Interviews FOREIGN KEY(IDInterview)
REFERENCES Interviews (IDInterview);
ALTER TABLE Interviewers ADD CONSTRAINT FK_Interviewers_Persons FOREIGN KEY(IDInterviewer)
REFERENCES Persons (IDPersonnel);
ALTER TABLE Interviews ADD CONSTRAINT FK_Interviews_InterviewTypes FOREIGN KEY(InterviewType)
REFERENCES InterviewTypes (IDType);
ALTER TABLE Interviews ADD CONSTRAINT FK_Interviews_Persons FOREIGN KEY(IDCandidate)
REFERENCES Persons (IDPersonnel);
ALTER TABLE Interviews ADD CONSTRAINT FK_Interviews_Positions FOREIGN KEY(IDRole)
REFERENCES Positions (IDRole);
ALTER TABLE Positions ADD CONSTRAINT FK_Positions_Areas FOREIGN KEY(IDArea)
REFERENCES Areas (IDArea);
