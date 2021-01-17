CREATE TABLE "ACCOUNT" (
"sort code" NUMBER NOT NULL,
"account number" NUMBER NOT NULL,
"name" CHAR(20 ) NOT NULL,
"start date" DATE NOT NULL,
"end date" DATE NULL,
"product id" NUMBER(11,0) NOT NULL,
PRIMARY KEY ("sort code", "account number") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "PRODUCT" (
"product id" NUMBER(11,0) NOT NULL,
"name" CHAR(40 ) NOT NULL,
"description" CLOB NULL,
"start date" DATE NOT NULL,
"end date" DATE NULL,
PRIMARY KEY ("product id") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "INDIVIDUAL" (
"party id" NUMBER(11,0) NOT NULL,
"first name" VARCHAR2(255) NOT NULL,
"surname" VARCHAR2(255) NOT NULL,
"date of birth" DATE NULL,
PRIMARY KEY ("party id") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "CUSTOMER" (
"customer id" NUMBER(11,0) NOT NULL,
"registered mobile number" NUMBER NOT NULL,
PRIMARY KEY ("customer id") 
)
NOCOMPRESS 
NOPARALLEL ;
COMMENT ON COLUMN "CUSTOMER"."customer id" IS 'A Customer is any party who has made contact with the Bank and who has been recorded for the purposes of communication.  This may be a party interested in, actively, or historically holding an ACCOUNT with the Bank.  It may also be a party who has requested an ad hoc communication, e.g. in the case of a general enquiry or compaint.';

CREATE TABLE "INDIVIDUAL ROLE" (
"role id" NUMBER(11,0) NOT NULL,
"start date" DATE NOT NULL,
"end date" DATE NULL,
"individual id" NUMBER(11,0) NOT NULL,
PRIMARY KEY ("role id") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "EMPLOYEE" (
"employee id" NUMBER(11,0) NOT NULL,
"employee number" NUMBER NOT NULL,
PRIMARY KEY ("employee id") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "CUSTOMER ACCOUNT" (
"customer id" NUMBER(11,0) NOT NULL,
"sort code" NUMBER NOT NULL,
"account number" NUMBER NOT NULL,
PRIMARY KEY ("customer id", "sort code", "account number") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "RATE CONDITION" (
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "TRANSACTION TYPE" (
"code" CHAR(10 ) NOT NULL,
"description" CHAR(30 ) NOT NULL,
PRIMARY KEY ("code") 
)
NOCOMPRESS 
NOPARALLEL ;
COMMENT ON COLUMN "TRANSACTION TYPE"."code" IS 'Code denoting the reference value.';
COMMENT ON COLUMN "TRANSACTION TYPE"."description" IS 'Description associated with reference code value.';

CREATE TABLE "TRANSACTION STATUS" (
"transaction id" NUMBER(11,0) NOT NULL,
"status code" CHAR(10 ) NOT NULL,
"timestamp" DATE NOT NULL,
PRIMARY KEY ("transaction id", "status code", "timestamp") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "OVERDRAFT FACILITY" (
"sort code" NUMBER NOT NULL,
"account number" NUMBER NOT NULL,
"start date" DATE NOT NULL,
"end date" DATE NULL,
"amount" NUMBER NOT NULL,
PRIMARY KEY ("sort code", "account number", "start date") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "ACCOUNT BALANCE" (
"sort code" NUMBER NOT NULL,
"account number" NUMBER NOT NULL,
"timestamp" DATE NOT NULL,
"amount" NUMBER NOT NULL,
"balance type code" CHAR(10 ) NOT NULL,
PRIMARY KEY ("sort code", "account number", "timestamp") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "TRANSACTION" (
"transaction id" NUMBER(11,0) NOT NULL,
"sort code" NUMBER NOT NULL,
"account number" NUMBER NOT NULL,
"timestamp" DATE NOT NULL,
"amount" NUMBER NOT NULL,
"transaction type code" CHAR(10 ) NOT NULL,
"reference" CHAR(30 ) NULL,
"description" CHAR(60 ) NOT NULL,
PRIMARY KEY ("transaction id") 
)
NOCOMPRESS 
NOPARALLEL ;
CREATE TABLE "BALANCE TYPE" (
"code" CHAR(10 ) NOT NULL,
"description" CHAR(30 ) NOT NULL,
PRIMARY KEY ("code") 
)
NOCOMPRESS 
NOPARALLEL ;
COMMENT ON COLUMN "BALANCE TYPE"."code" IS 'Code denoting the reference value.';
COMMENT ON COLUMN "BALANCE TYPE"."description" IS 'Description associated with reference code value.';

CREATE TABLE "TRANSACTION STATUS TYPE" (
"code" CHAR(10 ) NOT NULL,
"description" CHAR(30 ) NOT NULL,
PRIMARY KEY ("code") 
)
NOCOMPRESS 
NOPARALLEL ;
COMMENT ON COLUMN "TRANSACTION STATUS TYPE"."code" IS 'Code denoting the reference value.';
COMMENT ON COLUMN "TRANSACTION STATUS TYPE"."description" IS 'Description associated with reference code value.';


ALTER TABLE "INDIVIDUAL" ADD CONSTRAINT "Individual plays Role" FOREIGN KEY ("party id") REFERENCES "INDIVIDUAL ROLE" ("individual id");
ALTER TABLE "INDIVIDUAL ROLE" ADD CONSTRAINT "Individual Role is Customer" FOREIGN KEY ("role id") REFERENCES "CUSTOMER" ("customer id");
ALTER TABLE "INDIVIDUAL ROLE" ADD CONSTRAINT "Individual Role is Employee" FOREIGN KEY ("role id") REFERENCES "EMPLOYEE" ("employee id");
ALTER TABLE "CUSTOMER" ADD CONSTRAINT "Customer holds Account" FOREIGN KEY ("customer id") REFERENCES "CUSTOMER ACCOUNT" ("customer id");
ALTER TABLE "ACCOUNT" ADD CONSTRAINT "Account is held by Customer" FOREIGN KEY ("sort code", "account number") REFERENCES "CUSTOMER ACCOUNT" ("sort code", "account number");
ALTER TABLE "PRODUCT" ADD CONSTRAINT "Product defines Account" FOREIGN KEY ("product id") REFERENCES "ACCOUNT" ("product id");
ALTER TABLE "ACCOUNT" ADD CONSTRAINT "Account has Transaction" FOREIGN KEY ("sort code", "account number") REFERENCES "TRANSACTION" ("sort code", "account number");
ALTER TABLE "TRANSACTION" ADD CONSTRAINT "Transaction has Status" FOREIGN KEY ("transaction id") REFERENCES "TRANSACTION STATUS" ("transaction id");
ALTER TABLE "TRANSACTION STATUS TYPE" ADD CONSTRAINT "Status Type describes Transaction Status" FOREIGN KEY ("code") REFERENCES "TRANSACTION STATUS" ("status code");
ALTER TABLE "TRANSACTION TYPE" ADD CONSTRAINT "Transaction Type describes Transaction" FOREIGN KEY ("code") REFERENCES "TRANSACTION" ("transaction type code");
ALTER TABLE "BALANCE TYPE" ADD CONSTRAINT "Balance Type describes Balance" FOREIGN KEY ("code") REFERENCES "ACCOUNT BALANCE" ("balance type code");
ALTER TABLE "ACCOUNT" ADD CONSTRAINT "Account has Overdraft Facility" FOREIGN KEY ("sort code", "account number") REFERENCES "OVERDRAFT FACILITY" ("sort code", "account number");
ALTER TABLE "ACCOUNT" ADD CONSTRAINT "Account has Balance" FOREIGN KEY ("sort code", "account number") REFERENCES "ACCOUNT BALANCE" ("sort code", "account number");

