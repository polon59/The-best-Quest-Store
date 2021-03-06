CREATE DATABASE queststore;

CREATE TABLE appuser (
    login VARCHAR(20) PRIMARY KEY,
    password VARCHAR(25),
    first_name VARCHAR(25),
    last_name VARCHAR(25),
    email VARCHAR(40),
    appuser_type VARCHAR(10)
);

CREATE TABLE mentor (
    id SERIAL PRIMARY KEY,
    appuser_login VARCHAR(20) REFERENCES appuser(login)
);

CREATE TABLE classroom (
    id SERIAL PRIMARY KEY,
    classroom_name VARCHAR(20)
);

CREATE TABLE mentor_classroom (
    mentor_id INTEGER REFERENCES mentor(id),
    classroom_id INTEGER REFERENCES classroom(id),
    PRIMARY KEY (mentor_id, classroom_id) 
);

CREATE TABLE degree (
    id SERIAL PRIMARY KEY,
    degree_name VARCHAR(20),
    min_earned_coolcoins INTEGER
);

CREATE TABLE codecooler (
    id SERIAL PRIMARY KEY,
    appuser_login VARCHAR(20) REFERENCES appuser(login),
    classroom_id INTEGER REFERENCES classroom(id),
    earned_coolcoins INTEGER,
    wallet INTEGER DEFAULT 0
);

CREATE TABLE artifact (  
    id SERIAL PRIMARY KEY,
    artifact_name VARCHAR(40),
    artifact_description VARCHAR(200),
    cost INTEGER,
    category VARCHAR(20)
);

CREATE TABLE codecooler_artifact (
    id SERIAL PRIMARY KEY,
    codecooler_id INTEGER REFERENCES codecooler(id),
    artifact_id INTEGER REFERENCES artifact(id),
    purchase_date BIGINT,
    use_date BIGINT
);

CREATE TABLE quest (
    id SERIAL PRIMARY KEY,
    quest_name VARCHAR(40),
    quest_description VARCHAR(200),
    prize INTEGER,
    category VARCHAR(20)
);

CREATE TABLE codecooler_quest (
    id SERIAL PRIMARY KEY,
    codecooler_id INTEGER REFERENCES codecooler(id),
    quest_id INTEGER REFERENCES quest(id),
    mark_date BIGINT
);

CREATE TABLE team (
    id SERIAL PRIMARY KEY,
    team_name VARCHAR(40),
    artifact_id INTEGER REFERENCES artifact(id),
    leader_id INTEGER REFERENCES codecooler(id),
    status VARCHAR(25) DEFAULT 'Pending'
);

CREATE TABLE codecooler_team (
    codecooler_id INTEGER REFERENCES codecooler(id),
    team_id INTEGER REFERENCES team(id),
    coolcoins INTEGER,
    PRIMARY KEY (codecooler_id, team_id)
);
