-------- EXEMPLE D'INSERTION POUR TESTER 

-- POUR LA TABLE UTILISATEUR

INSERT INTO Utilisateur (UtilisateurID, Nom, Prenom, Adresse, DateNaissance, DateInscription, Login, MotDePasse)
VALUES (1, 'ORTANCA', 'Baris', '13 rue je ne sais plus', TO_DATE('2001-01-01', 'YYYY-MM-DD'), TO_DATE('2023-10-30', 'YYYY-MM-DD'), 'bortanca1', 'motdepasse1');

-- POUR LA TABLE TACHE

INSERT INTO Tache (TacheID, Intitule, Description, DateEcheance, Priorite, Statut, LienExterne, TachePeriodique, DateDebut, DateFin, Periode, TacheMereID)
VALUES (1, 'faire le projets', 'Le projets est un projets de bdd', TO_DATE('2023-11-10', 'YYYY-MM-DD'), 2, 'Non Terminée', 'https://moodles', 'N', NULL, NULL, NULL, NULL);

-- POUR LA TABLE PROJET

INSERT INTO Projet (ProjetID, NomProjet)
VALUES (1, 'Projet A');

-- POUR LA TABLE LISTE DES TACHES

INSERT INTO ListeDeTaches (ListeID, NomListe)
VALUES (1, 'Liste 1');

-- POUR LA TABLE DES ASSIGNATIONS DES TACHES

INSERT INTO AssignationTaches (UtilisateurID, TacheID)
VALUES (1, 1);

-- POUR LA TABLE DES TACHES FINI

INSERT INTO TacheFini (FinitTacheID, TacheID)
VALUES (1, 1);

-- POUR LA TABLE DES TACHES A REALISER 

INSERT INTO TacheARealiser (RealisationTacheID, TacheID)
VALUES (1, 1);
