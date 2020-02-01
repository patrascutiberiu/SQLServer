CREATE TABLE ETUDIANTS_2(
   IDETUDIANT INT PRIMARY KEY IDENTITY NOT NULL ,
   NOM VARCHAR(50) NOT NULL,
   PRENOM VARCHAR(50) NOT NULL,
   DATEENTREE DATETIME
   DEFAULT GETDATE()
);

CREATE TABLE MATIERES_2(
   IDMATIERE INT PRIMARY KEY IDENTITY NOT NULL,
   LBLMATIERE VARCHAR(50) NOT NULL,
   COEFFICIENT INT CHECK(COEFFICIENT < 10) NOT NULL
);

CREATE TABLE CONTROLER_2(
	IDMATIERE INT,
	IDETUDIANT INT,
	DATECTRL DATE NOT NULL,
	CONSTRAINT FK_ETUD_2 FOREIGN KEY (IDETUDIANT) REFERENCES ETUDIANTS_2(IDETUDIANT),
	CONSTRAINT FK_MAT_2 FOREIGN KEY (IDMATIERE) REFERENCES MATIERES_2(IDMATIERE),
	CONSTRAINT PK_CTRL PRIMARY KEY(DATECTRL,IDMATIERE,IDETUDIANT),
	MOYENNE DECIMAL(15,2) CHECK (MOYENNE < 20) NOT NULL
);
alter table CONTROLER_2 DROP CONSTRAINT PK_ID_2 
ALTER TABLE CONTROLER_2 ADD CONSTRAINT PK_CTRL PRIMARY KEY (DATECTRL,IDMATIERE,IDETUDIANT)
