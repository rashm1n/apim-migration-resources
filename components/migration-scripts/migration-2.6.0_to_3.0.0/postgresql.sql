DROP TABLE IF EXISTS AM_SYSTEM_APPS;
CREATE SEQUENCE AM_API_SYSTEM_APPS_SEQUENCE START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS AM_SYSTEM_APPS (
    ID INTEGER NOT NULL DEFAULT NEXTVAL('AM_API_SYSTEM_APPS_SEQUENCE'),
    NAME VARCHAR(50) NOT NULL,
    CONSUMER_KEY VARCHAR(512) NOT NULL,
    CONSUMER_SECRET VARCHAR(512) NOT NULL,
    CREATED_TIME TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (NAME),
    UNIQUE (CONSUMER_KEY),
    PRIMARY KEY (ID)
);

	CREATE TABLE IF NOT EXISTS AM_API_CLIENT_CERTIFICATE (
  TENANT_ID INTEGER NOT NULL,
  ALIAS VARCHAR(45) NOT NULL,
  API_ID INTEGER NOT NULL,
  CERTIFICATE BYTEA NOT NULL,
  REMOVED BOOLEAN NOT NULL DEFAULT '0',
  TIER_NAME VARCHAR (512),
  FOREIGN KEY (API_ID) REFERENCES AM_API (API_ID) ON DELETE CASCADE,
  PRIMARY KEY (ALIAS, TENANT_ID, REMOVED)
);

ALTER TABLE AM_POLICY_SUBSCRIPTION ADD MONETIZATION_PLAN VARCHAR(25) NULL DEFAULT NULL,
   ADD FIXED_RATE VARCHAR(15) NULL DEFAULT NULL, 
   ADD BILLING_CYCLE VARCHAR(15) NULL DEFAULT NULL, 
   ADD PRICE_PER_REQUEST VARCHAR(15) NULL DEFAULT NULL, 
   ADD CURRENCY VARCHAR(15) NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS AM_MONETIZATION_USAGE_PUBLISHER (
	ID VARCHAR(100) NOT NULL,
	STATE VARCHAR(50) NOT NULL,
	STATUS VARCHAR(50) NOT NULL,
	STARTED_TIME VARCHAR(50) NOT NULL,
	PUBLISHED_TIME VARCHAR(50) NOT NULL,
	PRIMARY KEY(ID)
);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER TABLE AM_API_COMMENTS
  DROP COLUMN COMMENT_ID,
  ADD COLUMN COMMENT_ID VARCHAR(255) NOT NULL DEFAULT uuid_generate_v1(),
  ADD PRIMARY KEY (COMMENT_ID);

ALTER TABLE AM_API_RATINGS
  DROP COLUMN RATING_ID,
  ADD COLUMN RATING_ID VARCHAR(255) NOT NULL DEFAULT uuid_generate_v1(),
  ADD PRIMARY KEY (RATING_ID);

CREATE TABLE IF NOT EXISTS AM_NOTIFICATION_SUBSCRIBER (
    UUID VARCHAR(255),
    CATEGORY VARCHAR(255),
    NOTIFICATION_METHOD VARCHAR(255),
    SUBSCRIBER_ADDRESS VARCHAR(255) NOT NULL,
    PRIMARY KEY(UUID, SUBSCRIBER_ADDRESS)
);

ALTER TABLE AM_EXTERNAL_STORES
ADD LAST_UPDATED_TIME TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE AM_API
  ADD API_TYPE VARCHAR(10) NULL DEFAULT NULL;

CREATE SEQUENCE AM_API_PRODUCT_MAPPING_SEQUENCE START WITH 1 INCREMENT BY 1;
CREATE TABLE IF NOT EXISTS AM_API_PRODUCT_MAPPING (
  API_PRODUCT_MAPPING_ID INTEGER DEFAULT nextval('am_api_product_mapping_sequence'),
  API_ID INTEGER,
  URL_MAPPING_ID INTEGER,
FOREIGN KEY (API_ID) REFERENCES AM_API(API_ID) ON DELETE CASCADE,
FOREIGN KEY (URL_MAPPING_ID) REFERENCES AM_API_URL_MAPPING(URL_MAPPING_ID) ON DELETE CASCADE,
PRIMARY KEY(API_PRODUCT_MAPPING_ID)
);

DROP TABLE IF EXISTS AM_REVOKED_JWT;
CREATE TABLE IF NOT EXISTS AM_REVOKED_JWT (
    UUID VARCHAR(255) NOT NULL,
    SIGNATURE VARCHAR(2048) NOT NULL,
    EXPIRY_TIMESTAMP BIGINT NOT NULL,
    TENANT_ID INTEGER DEFAULT -1,
    TOKEN_TYPE VARCHAR(15) DEFAULT 'DEFAULT',
    TIME_CREATED TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (UUID)
);
