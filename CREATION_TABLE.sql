-------- CREATION DES TABLES  

---- CREATION TABLE UTILISATEUR AISI QUE LES CONDITIONS

CREATE TABLE Utilisateur (
    UtilisateurID NUMBER PRIMARY KEY,
    Nom VARCHAR2(255),
    Prenom VARCHAR2(255),
    Adresse VARCHAR2(255),
    DateNaissance DATE,
    DateInscription DATE,
    Login VARCHAR2(20) UNIQUE,
    MotDePasse VARCHAR2(255),
    Score NUMBER,
    Niveau NUMBER
);

CREATE OR REPLACE TRIGGER CheckLoginFormat
BEFORE INSERT OR UPDATE ON Utilisateur
FOR EACH ROW
BEGIN
    IF :new.Login != LOWER(SUBSTR(:new.Prenom, 1, 1) || SUBSTR(:new.Nom, 1, 7) || LPAD(TO_CHAR(:new.UtilisateurID), 2, '0')) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Le format du Login est incorrect');
    END IF;
END;

CREATE OR REPLACE TRIGGER CheckPasswordFormat
BEFORE INSERT OR UPDATE ON Utilisateur
FOR EACH ROW
BEGIN
    IF REGEXP_LIKE(:new.MotDePasse, '[^a-zA-Z0-9_]') THEN
        RAISE_APPLICATION_ERROR(-20002, 'Le format du MotDePasse est incorrect');
    END IF;
END;

CREATE UNIQUE INDEX UniqueLogin ON Utilisateur (Login);



----- CREATION DE LA TABLE TACHE AINSI QUE LES CONDITIONS

CREATE TABLE Tache (
    TacheID NUMBER PRIMARY KEY,
    Intitule VARCHAR2(255),
    DescriptionTache VARCHAR2(255),
    DateEcheance DATE,
    Priorite NUMBER,
    Statut VARCHAR2(20),
    LienExterne VARCHAR2(255),
    TachePeriodique CHAR(1),
    DateDebut DATE,
    DateFin DATE,
    Periode NUMBER,
    TacheMereID NUMBER,
    CONSTRAINT CheckNoRecursiveDependency
        CHECK (TacheMereID IS NULL OR TacheID != TacheMereID)
);

CREATE OR REPLACE TRIGGER CheckNoRecursiveDependency
BEFORE INSERT OR UPDATE ON Tache
FOR EACH ROW
BEGIN
    IF :new.TacheMereID = :new.TacheID THEN
        RAISE_APPLICATION_ERROR(-20003, 'Les dépendances récursives ne sont pas autorisées');
    END IF;
END;

----- CREATION DE LA TABLE PROJET 

CREATE TABLE Projet (
    ProjetID NUMBER PRIMARY KEY,
    NomProjet VARCHAR(255)
);

----- CREATION DE LA TABLE LISTE DES TACHES 

CREATE TABLE ListeDeTaches (
    ListeID NUMBER PRIMARY KEY,
    NomListe VARCHAR(255)
);


----- CREATION DE LA TABLE D'ASSIGNATION DES TACHES AU UTILISATEUR 

CREATE TABLE AssignationTaches (
    UtilisateurID NUMBER,
    TacheID NUMBER,
    PRIMARY KEY (UtilisateurID, TacheID),
    FOREIGN KEY (UtilisateurID) REFERENCES Utilisateur(UtilisateurID),
    FOREIGN KEY (TacheID) REFERENCES Tache(TacheID)
);

----- CREATION DE LA TABLE DES TACHES FINIS

CREATE TABLE TacheFini (
    FiniTacheID NUMBER PRIMARY KEY,
    TacheID NUMBER,
    FOREIGN KEY (TacheID) REFERENCES Tache(TacheID)
);

----- CREATION DE LA TABLE DES TACHE A REALISER 

CREATE TABLE TacheARealiser (
    RealisationTacheID NUMBER PRIMARY KEY,
    TacheID NUMBER,
    FOREIGN KEY (TacheID) REFERENCES Tache(TacheID)
);

