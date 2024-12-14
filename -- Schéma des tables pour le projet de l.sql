-- Schéma des tables pour le projet de l'interface Julia

-- Table des utilisateurs
CREATE TABLE Utilisateurs (
    id_utilisateur SERIAL PRIMARY KEY,        -- Identifiant unique de l'utilisateur
    nom VARCHAR(100) NOT NULL,               -- Nom de l'utilisateur
    email VARCHAR(100) UNIQUE NOT NULL,      -- Email unique pour chaque utilisateur
    mot_de_passe VARCHAR(255) NOT NULL,      -- Mot de passe sécurisé
    role ENUM('apprenant', 'formateur') NOT NULL -- Rôle de l'utilisateur
);

-- Table des cours
CREATE TABLE Cours (
    id_cours SERIAL PRIMARY KEY,             -- Identifiant unique du cours
    titre VARCHAR(150) NOT NULL,             -- Titre du cours
    description TEXT,                        -- Description du cours
    createur_id INT REFERENCES Utilisateurs(id_utilisateur) -- Formateur qui a créé le cours
);

-- Table des leçons
CREATE TABLE Lecons (
    id_lecon SERIAL PRIMARY KEY,             -- Identifiant unique de la leçon
    id_cours INT REFERENCES Cours(id_cours) ON DELETE CASCADE, -- Cours associé à la leçon
    titre VARCHAR(150) NOT NULL,             -- Titre de la leçon
    contenu TEXT NOT NULL                    -- Contenu de la leçon
);

-- Table des résultats des tests
CREATE TABLE Resultats_tests (
    id_resultat SERIAL PRIMARY KEY,          -- Identifiant unique du résultat
    id_utilisateur INT REFERENCES Utilisateurs(id_utilisateur) ON DELETE CASCADE, -- Utilisateur ayant passé le test
    id_lecon INT REFERENCES Lecons(id_lecon) ON DELETE CASCADE, -- Leçon associée au test
    score INT NOT NULL,                      -- Score obtenu au test
    date_passage TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date du passage du test
);

-- Table des progrès des apprenants
CREATE TABLE Progres (
    id_progres SERIAL PRIMARY KEY,           -- Identifiant unique du progrès
    id_utilisateur INT REFERENCES Utilisateurs(id_utilisateur) ON DELETE CASCADE, -- Apprenant concerné
    id_lecon INT REFERENCES Lecons(id_lecon) ON DELETE CASCADE, -- Leçon concernée
    etat ENUM('non_commence', 'en_cours', 'termine') DEFAULT 'non_commence' -- État d'avancement
);

-- Table des interactions avec le code Julia (historique des soumissions)
CREATE TABLE Historique_exercices (
    id_historique SERIAL PRIMARY KEY,        -- Identifiant unique de l'historique
    id_utilisateur INT REFERENCES Utilisateurs(id_utilisateur) ON DELETE CASCADE, -- Apprenant ayant soumis le code
    code_soumis TEXT NOT NULL,               -- Code Julia soumis par l'utilisateur
    resultat TEXT,                           -- Résultat de l'exécution
    date_soumission TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Date de soumission
);
