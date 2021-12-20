CREATE DATABASE bank_deposits;

USE bank_deposits;

SELECT * FROM bank_deposits.fulltable;

ALTER TABLE fulltable 
RENAME COLUMN MyUnknownColumn
TO id;

CREATE TABLE clients 
SELECT id, age, job, marital, education 
FROM fulltable;

CREATE TABLE bk_profile
SELECT id, default, balance, housing, loan
FROM fulltable;

ALTER TABLE fulltable
RENAME COLUMN `Subscription to deposit (target)`
TO target_subscription;

CREATE TABLE campaign
SELECT id, contact, duration, previous, pdays, poutcome, target_subscription
FROM fulltable;
