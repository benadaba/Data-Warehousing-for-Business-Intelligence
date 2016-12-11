
--1 FACILITY
CREATE TABLE FACILITY(
FACNO INTEGER,
FACNAME VARCHAR(255) NOT NULL,
CONSTRAINT PK_FAC PRIMARY KEY (FACNO)

);

--2. EMPLOYEE
CREATE TABLE EMPLOYEE(
EMPNO INTEGER,
EMPNAME VARCHAR(255) NOT NULL,
DEPARTMENT VARCHAR(255),
EMAIL VARCHAR(255),
PHONE INTEGER,
CONSTRAINT PK_EMP PRIMARY KEY (EMPNO),
CONSTRAINT CHK_EMP CHECK(PHONE <= 15)

);

--3 RESOURCETBL
CREATE TABLE RESOURCETBL(
RESNO INTEGER,
RESNAME VARCHAR(255) NOT NULL,
RATE VARCHAR(255),
CONSTRAINT PK_RES PRIMARY KEY (RESNO)

);


--4 CUSTOMER
CREATE TABLE CUSTOMER( 
CUSTNO INTEGER,
CUSTNAME VARCHAR(255) NOT NULL,
ADDRESS VARCHAR(255),
INTERNAL CHAR(1),
CONTACT VARCHAR(255),
PHONE INTEGER,
CITY VARCHAR(255),
STATE VARCHAR(255),
ZIP INTEGER,
CONSTRAINT PK_CUS PRIMARY KEY (CUSTNO),
CONSTRAINT CHK_CUS CHECK (PHONE <= 15),
CONSTRAINT CHK_CUS_ZIP CHECK(ZIP <=10)

);

--5 LOCATION
CREATE TABLE LOCATION(
LOCNO INTEGER,
FACNO INTEGER,
LOCNAME VARCHAR(255) NOT NULL,
CONSTRAINT PK_LOC PRIMARY KEY (LOCNO),
CONSTRAINT FK_LOC FOREIGN KEY (FACNO)
REFERENCES FACILITY

);

-- 6 EVENTREQUEST
CREATE TABLE EVENTREQUEST(
EVENTNO INTEGER,
DATEHELD DATE,
DATEREQ DATE,
CUSTNO INTEGER,
FACNO INTEGER,
DATEAUTH DATE,
STATUS CHAR(1) NOT NULL,
ESTCOST INTEGER,
ESTAUDIENCE INTEGER,
BUDNO INTEGER,
CONSTRAINT PK_EVR PRIMARY KEY (EVENTNO),
CONSTRAINT FK_EVR_CUS FOREIGN KEY (CUSTNO) REFERENCES CUSTOMER,
CONSTRAINT FK_EVR_FAC FOREIGN KEY (FACNO) REFERENCES FACILITY

);

--7 EVENTPLAN
CREATE TABLE EVENTPLAN(
PLANNO INTEGER,
EVENTNO INTEGER,
WORKDATE DATE,
NOTES VARCHAR(1000),
ACTIVITY VARCHAR(500),
EMPNO INTEGER,
CONSTRAINT PK_EVP PRIMARY KEY (PLANNO),
CONSTRAINT FK_EVP_EVR FOREIGN KEY (EVENTNO) REFERENCES EVENTREQUEST


);


-- 8 EVENTPLANLINE
CREATE TABLE EVENTPLANLINE(
PLANNO INTEGER,
LINENO INTEGER,
TIMESTART DATE,
TIMEEND DATE,
NUMBERFLD INTEGER,
LOCNO INTEGER,
RESNO INTEGER,
CONSTRAINT PK_EVPLL PRIMARY KEY (PLANNO, LINENO),
CONSTRAINT FK_EVPLL_EVP FOREIGN KEY (PLANNO) REFERENCES EVENTPLAN,
CONSTRAINT FK_EVPLL_LOC FOREIGN KEY (LOCNO) REFERENCES LOCATION,
CONSTRAINT FK_EVPLL_RES FOREIGN KEY (RESNO) REFERENCES RESOURCETBL
);

