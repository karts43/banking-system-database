-----------------------------------------------------------------------------------------
-- STEP 1: CREATE CUSTOMERS TABLE (BASIC)
-----------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS
(
  CUSTOMERID NUMBER,
  NAME      VARCHAR2(30) NOT NULL,
  ADDRESS   VARCHAR2(50) NULL,
  PHONENO   NUMBER(10)   CHECK (LENGTH(PHONENO)=10),
  EMAIL     VARCHAR2(25) NULL,
  CONSTRAINT CUSTOMERID_PK_CUST_PROJECT PRIMARY KEY (CUSTOMERID)
);

-- Check constraints on CUSTOMERS
	
SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CUSTOMERS';


-----------------------------------------------------------------------------------------
-- STEP 2: MODIFY EMAIL COLUMN (DROP + ADD WITH UNIQUE + CHECK)
-----------------------------------------------------------------------------------------

ALTER TABLE CUSTOMERS
DROP COLUMN EMAIL;

ALTER TABLE CUSTOMERS
ADD EMAIL VARCHAR2(100) UNIQUE
    CHECK (EMAIL LIKE '%@%');

-- Verify again

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CUSTOMERS';


-----------------------------------------------------------------------------------------
-- STEP 3: CREATE ACCOUNTS TABLE, THEN FIX BALANACE -> BALANCE
-----------------------------------------------------------------------------------------

CREATE TABLE ACCOUNTS
( 
  ACCOUNT_ID   NUMBER,
  CUSTOMERID   NUMBER,
  ACCOUNT_TYPE VARCHAR2(15) NOT NULL,
  BALANACE     NUMBER,
  CONSTRAINT ACCOUNT_ID_PK_ACCT_PROJECT PRIMARY KEY (ACCOUNT_ID),
  CONSTRAINT CUSTOMERID_FK_ACCT_PROJECT FOREIGN KEY (CUSTOMERID)
      REFERENCES CUSTOMERS(CUSTOMERID)
);

-- Check constraints on ACCOUNTS

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'ACCOUNTS';

-- Rename BALANACE to BALANCE

ALTER TABLE ACCOUNTS
RENAME COLUMN BALANACE TO BALANCE;


-----------------------------------------------------------------------------------------
-- STEP 4: CREATE TRANSACTIONS TABLE
-----------------------------------------------------------------------------------------

CREATE TABLE TRANSACTIONS
(
  TRANSACTION_ID   NUMBER,
  ACCOUNT_ID       NUMBER,
  TRANSACTION_TYPE VARCHAR2(20) NOT NULL,
  AMOUNT           NUMBER NOT NULL,
  TRANSACTION_DATE DATE,
  CONSTRAINT TRANSACTION_ID_PK_TRAN_PROJECT PRIMARY KEY (TRANSACTION_ID),
  CONSTRAINT ACCOUNT_ID_FK_TRAN_PROJECT FOREIGN KEY (ACCOUNT_ID)
      REFERENCES ACCOUNTS(ACCOUNT_ID)
);

-- Check constraints on TRANSACTIONS

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TRANSACTIONS';


-----------------------------------------------------------------------------------------
-- STEP 5: CREATE CREDITCARD TABLE, THEN RENAME LIMIT -> CARD_LIMIT
-----------------------------------------------------------------------------------------

CREATE TABLE CREDITCARD
(
  CREDITCARDID NUMBER,
  CUSTOMERID   NUMBER,
  CARDTYPE     VARCHAR2(30) NOT NULL,
  LIMIT        NUMBER NOT NULL,
  EXPIRYDATE   DATE,
  CONSTRAINT CREDITCARDID_PK_CRED_PROJECT PRIMARY KEY (CREDITCARDID),
  CONSTRAINT CUSTOMERID_FK_CRED_PROJECT FOREIGN KEY (CUSTOMERID)
      REFERENCES CUSTOMERS(CUSTOMERID)
);

-- Check constraints on CREDITCARD

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'CREDITCARD';

-- Rename LIMIT to CARD_LIMIT (better name, avoids reserved word issues)

ALTER TABLE CREDITCARD
RENAME COLUMN LIMIT TO CARD_LIMIT;


-----------------------------------------------------------------------------------------
-- STEP 6: CREATE LOAN TABLE
-----------------------------------------------------------------------------------------

CREATE TABLE LOAN
(
  LOANID        NUMBER,
  CUSTOMERID    NUMBER,
  LOANAMOUNT    NUMBER NOT NULL,
  INTERESTRATE  NUMBER NOT NULL,
  REPAYMENTTERM VARCHAR2(50) NULL,
  CONSTRAINT LOANID_PK_LOAN_PROJECT PRIMARY KEY (LOANID),
  CONSTRAINT CUSTOMERID_FK_LOAN_PROJECT FOREIGN KEY (CUSTOMERID)
      REFERENCES CUSTOMERS(CUSTOMERID)
);

-- Check constraints on LOAN

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'LOAN';


-----------------------------------------------------------------------------------------
-- STEP 7: CREATE BRANCH TABLE
-----------------------------------------------------------------------------------------

CREATE TABLE BRANCH
(
  BRANCHID NUMBER,
  BNAME    VARCHAR2(35) NOT NULL,
  ADDRESS  VARCHAR2(20) NOT NULL,
  CONSTRAINT BRANCHID_PK_BRAN_PROJECT PRIMARY KEY (BRANCHID)
);

-- Check constraints on BRANCH

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'BRANCH';


-----------------------------------------------------------------------------------------
-- STEP 8: CREATE EMPLOYEES TABLE
-----------------------------------------------------------------------------------------

CREATE TABLE EMPLOYEES
(
  EMPID    NUMBER,
  ENAME    VARCHAR2(15) NOT NULL,
  ROLE     VARCHAR2(15) NULL,
  BRANCHID NUMBER,
  CONSTRAINT EMPID_PK_EMPL_PROJECT PRIMARY KEY (EMPID),
  CONSTRAINT BRANCHID_FK_EMPL_PROJECT FOREIGN KEY (BRANCHID)
      REFERENCES BRANCH(BRANCHID)
);

-- Check constraints on EMPLOYEES

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'EMPLOYEES';
