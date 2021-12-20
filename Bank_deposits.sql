-- Create the database, a table with full dataset before encoding and check the dataset
CREATE DATABASE bank_deposits;

USE bank_deposits;

CREATE TABLE bank_deposits.fulltable;

SELECT * FROM bank_deposits.fulltable;

-- Rename columns in accordance with SQL syntax (unique IDs, no space)
ALTER TABLE fulltable 
RENAME COLUMN MyUnknownColumn
TO id;

ALTER TABLE fulltable
RENAME COLUMN `Subscription to deposit (target)`
TO target_subscription;

-- Copy the full dataset table to use with encoded csv and compare both tables
CREATE TABLE fulltable_enc
LIKE fulltable;

-- Split the table into smaller tables to store data in relevant categories (clients, banking profile, campaign)
CREATE TABLE clients
SELECT id, age, job, marital, education 
FROM fulltable;

CREATE TABLE bk_profile
SELECT id, `default`, balance, housing, loan
FROM fulltable;

CREATE TABLE campaign
SELECT id, contact, duration, previous, pdays, poutcome, target_subscription
FROM fulltable;

-- Create temporary tables to test different queries
CREATE TEMPORARY TABLE bank_deposits.campaign_success
SELECT id AS client_id, age, job, marital, education, `default`, balance, housing, loan, contact, duration, pdays, previous
FROM fulltable
WHERE target_subscription='yes'
AND poutcome='success'
ORDER BY previous ASC;

SELECT *
FROM bank_deposits.campaign_success;

DROP TEMPORARY TABLE bank_deposits.campaign_success;

-- Create new tables only for relevant queries as deliverables

-- Stats on campaign outcomes reaching target: performance of last vs previous campaigns targeting
CREATE TABLE bank_deposits.campaign_reach
SELECT COUNT(id) AS client_count,
	ROUND(AVG(duration), 0) AS duration_avg,
    ROUND(AVG(previous), 0) AS previous_avg,
    poutcome,
    target_subscription
FROM fulltable
WHERE target_subscription='yes'
GROUP BY poutcome
ORDER BY client_count DESC;

SELECT *
FROM bank_deposits.campaign_reach;

-- Client personal and banking profiles reaching target subscription with successful outcome on a previous contact
CREATE TABLE bank_deposits.clients_reached
SELECT id AS client_id, age, job, marital, education, `default`, balance, housing, loan, contact, duration, pdays, previous
FROM fulltable
WHERE target_subscription='yes'
AND poutcome='success'
ORDER BY previous ASC;

SELECT *
FROM bank_deposits.clients_reached;

-- Most occuring client profiles reaching target subscription: refer to legend to interpret results
-- poutcome legend: 3 = success, 2 = other, 1 = failure, 0 = unknown
-- categorical columns legend: 0 = no, 1 = yes
CREATE TABLE bank_deposits.target_enc
SELECT COUNT(id) AS client_count, 
	ROUND(AVG(age), 2) AS age_avg,
	ROUND(AVG(`default`), 0) AS default_avg,
	ROUND(AVG(balance), 2) AS balance_avg,
	ROUND(AVG(housing), 0) AS housing_avg,
	ROUND(AVG(loan), 0) AS loan_avg,
	ROUND(AVG(duration), 2) AS duration_avg,
	poutcome
FROM fulltable_enc
WHERE target_subscription='1'
GROUP BY poutcome
ORDER BY poutcome DESC;

SELECT *
FROM bank_deposits.target_enc;

-- Run a few queries to analyze target banking profile (loan y/n, housing y/n) 
SELECT COUNT(id) AS client_count, loan
FROM fulltable
WHERE target_subscription='yes'
GROUP BY loan
ORDER BY COUNT(*) DESC;