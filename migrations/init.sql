# @todo move migrations to a separate container
# mysql node module doesn't support newer default MySQL authentication method
ALTER USER 'api'@'%' IDENTIFIED WITH mysql_native_password BY 'password';
# @todo insecure. Lock this down?
GRANT ALL PRIVILEGES ON *.* TO 'api'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;

# SET global general_log = 1;
# SET global log_output = 'table';

DROP TABLE IF EXISTS threat_scenario;
DROP TABLE IF EXISTS classification;

CREATE TABLE classification
(
    id   INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT classification_pk
        PRIMARY KEY (id)
);

INSERT INTO classification (name)
VALUES ('spoofing'),
       ('tampering'),
       ('repudiation'),
       ('information_disclosure'),
       ('denial_of_service'),
       ('elevation_of_privilege');

CREATE TABLE threat_scenario
(
    id                INT AUTO_INCREMENT,
    title             VARCHAR(50)  NOT NULL,
    description       VARCHAR(200) NULL,
    related_asset     VARCHAR(50)  NULL,
    classification_id INT          NOT NULL,
    impact            INT          NOT NULL,
    likelihood        INT          NOT NULL,
    CONSTRAINT threat_scenario_pk
        PRIMARY KEY (id),
    CONSTRAINT classification_fk
        FOREIGN KEY (classification_id)
            REFERENCES classification (id)
);

INSERT INTO threat_scenario
    (title, description, related_asset, classification_id, impact, likelihood)
VALUES
    ('scenario 1', 'scenario 1 description', null, 1, 0, 0),
    ('scenario 2', 'scenario 2 description', null, 4, 1, 0),
    ('scenario 3', 'scenario 3 description', null, 3, 3, 0),
    ('scenario 4', 'scenario 4 description', null, 2, 2, 0),
    ('scenario 5', 'scenario 5 description', null, 6, 0, 3),
    ('scenario 6', 'scenario 6 description', null, 5, 1, 0),
    ('scenario 7', 'scenario 1 description', null, 1, 0, 0),
    ('scenario 8', 'scenario 2 description', null, 4, 1, 0),
    ('scenario 9', 'scenario 3 description', null, 3, 3, 0),
    ('scenario 10', 'scenario 4 description', null, 2, 2, 0),
    ('scenario 11', 'scenario 5 description', null, 6, 0, 3),
    ('scenario 12', 'scenario 6 description', null, 5, 1, 0),
    ('scenario 13', 'scenario 4 description', null, 2, 2, 0),
    ('scenario 14', 'scenario 5 description', null, 6, 0, 3),
    ('scenario 15', 'scenario 6 description', null, 5, 1, 0)
