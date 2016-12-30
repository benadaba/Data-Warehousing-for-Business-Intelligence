/*Que2:List the customer number, customer name, event number, date held, 
facility number, facility name, and estimated audience cost per person (EstCost / EstAudience) 
for events held on 2013, in which the estimated cost per person is less than $0.2
 */

SELECT 
      EVENTNO, DATEHELD, CUSTOMER.CUSTNO, CUSTNAME, FACILITY.FACNO, FACNAME, 
      (EstCost / EstAudience) as EstCosPerAudience
FROM 
    EVENTREQUEST inner join CUSTOMER 
on EVENTREQUEST.CUSTNO = CUSTOMER.CUSTNO
inner join FACILITY
on EVENTREQUEST.FACNO = FACILITY.FACNO
WHERE 
    CUSTOMER.CITY = 'Boulder' 
    AND EXTRACT(YEAR FROM TO_DATE(DATEHELD, 'DD-MON-RR')) = 2013 
    AND (EstCost / EstAudience) < 0.2;
    
    
/*Que3:List the customer number, customer name, and total estimated costs for Approved events. 
The total amount of events is the sum of the estimated cost for each event. 
Group the results by customer number and customer name.
*/

SELECT 
       CUSTOMER.CUSTNO, CUSTNAME, SUM(ESTCOST) AS TTL_ESTCOST 
FROM 
    EVENTREQUEST inner join CUSTOMER 
on EVENTREQUEST.CUSTNO = CUSTOMER.CUSTNO
WHERE STATUS = 'Approved'
GROUP BY CUSTOMER.CUSTNO, CUSTNAME;


/*4.	Insert yourself as a new row in the Customer table.*/
INSERT INTO CUSTOMER
(CUSTNO, CUSTNAME, ADDRESS, INTERNAL, CONTACT, PHONE, CITY, STATE, ZIP)
VALUES('C106','Bernard', 'Box 12345', 'N', 'Football Captain', '4854252', 'LONDON','LO','58485');

SELECT * FROM CUSTOMER;


/*5.	Increase the rate by 10 percent of nurse resource in the resource table.*/

UPDATE RESOURCETBL
 SET RATE = RATE * 1.1
WHERE RESNAME = 'nurse';

SELECT * FROM RESOURCETBL;

/*delete a record */
DELETE FROM CUSTOMER
WHERE CUSTNAME = 'Bernard' AND
      CITY  = 'LONDON';
      
SELECT * FROM CUSTOMER;


/*1.	List the order number, order date, customer number, customer name (first and last), 
employee number, and employee name (first and last) of January 2013 orders placed 
by Colorado customers.*/

SELECT 
      ORDNO, ORDDATE ,ORDERCUSTOMER.CUSTNO, CUSTFIRSTNAME, CUSTLASTNAME,
      ORDEREMPLOYEE.EMPNO, EMPFIRSTNAME, EMPLASTNAME
FROM 
      ORDERTBL inner join ORDERCUSTOMER
ON ORDERTBL.CUSTNO = ORDERCUSTOMER.CUSTNO
inner join ORDEREMPLOYEE 
ON ORDERTBL.EMPNO = ORDEREMPLOYEE.EMPNO
WHERE 
      ORDDATE BETWEEN '01-JAN-2013' AND '31-JAN-2013' 
    AND   ORDERCUSTOMER.CUSTCITY = 'Colorado';
    

/*2.	List the customer number, name (first and last), order number, order date,
employee number, employee name (first and last), product number, product name, 
and order cost (OrdLine.Qty * ProdPrice) for products ordered on January 23, 2013, 
in which the order cost exceeds $150.*/

SELECT 
      ORDERTBL.ORDNO, ORDDATE ,ORDERCUSTOMER.CUSTNO, CUSTFIRSTNAME, CUSTLASTNAME,
      ORDEREMPLOYEE.EMPNO, EMPFIRSTNAME, EMPLASTNAME, PRODUCT.PRODNO, PRODNAME,
       (OrdLine.Qty * ProdPrice) AS OrderCost

FROM ORDERTBL 
  inner join ORDERCUSTOMER
  ON ORDERTBL.CUSTNO = ORDERCUSTOMER.CUSTNO
  inner join ORDEREMPLOYEE 
  ON ORDERTBL.EMPNO = ORDEREMPLOYEE.EMPNO
  inner join ORDLINE
  ON ORDERTBL.ORDNO = ORDLINE.ORDNO
  inner join PRODUCT
  ON ORDLINE.PRODNO = PRODUCT.PRODNO
WHERE 
      ORDDATE = '23-JAN-2013'
    AND   (OrdLine.Qty * ProdPrice) > 150;



/*3.	List the order number and total amount for orders placed on January 23, 2013.
The total amount of an order is the sum of the quantity times the product price 
of each product on the order.*/

SELECT 
      ORDLINE.ORDNO, SUM(ORDLINE.QTY*PRODPRICE) AS AMT

FROM 
      ORDERTBL inner join ORDLINE 
      ON ORDERTBL.ORDNO = ORDLINE.ORDNO
inner join PRODUCT
ON ORDLINE.PRODNO = PRODUCT.PRODNO
WHERE 
      ORDDATE = '23-JAN-2013' 
GROUP BY ORDLINE.ORDNO;




/*4.	List the order number, order date, customer name (first and last), \
and total amount for orders placed on January 23, 2013. The total amount of an
order is the sum of the quantity times the product price of each product on the order.*/

SELECT 
      ORDERTBL.ORDNO, ORDDATE ,ORDERCUSTOMER.CUSTNO, CUSTFIRSTNAME, CUSTLASTNAME,
      SUM(ORDLINE.QTY *PRODPRICE) AS TTL_AMT
FROM 
      ORDERTBL inner join ORDERCUSTOMER
ON ORDERTBL.CUSTNO = ORDERCUSTOMER.CUSTNO
inner join ORDLINE
ON ORDERTBL.ORDNO = ORDLINE.ORDNO
inner join PRODUCT
ON ORDLINE.PRODNO = PRODUCT.PRODNO
WHERE 
      ORDDATE = '23-JAN-2013'
group by ORDERTBL.ORDNO, ORDDATE, ORDERCUSTOMER.CUSTNO, CUSTFIRSTNAME, CUSTLASTNAME;



/*5.	Insert yourself as a new row in the Customer table.*/
INSERT INTO ORDERCUSTOMER
(CUSTNO, CUSTFIRSTNAME,CUSTLASTNAME, CUSTSTREET, CUSTCITY, CUSTSTATE, CUSTZIP, CUSTBAL)
VALUES ('C9999999', 'Bernard', 'Self','123 Self Street', 'London', 'LO', '12545-1425',300);


SELECT * FROM ORDERCUSTOMER;


/*6.	Insert an imaginary friend as a new row in the Employee table. */
INSERT INTO ORDEREMPLOYEE
(EMPNO, EMPFIRSTNAME,EMPLASTNAME,EMPPHONE,EMPEMAIL,SUPEMPNO,EMPCOMMRATE)
VALUES ('E9999999', 'Kofi', 'Friend','(404) 123-1234', 'kofi_friend@datapandas.com', 'E9884325', 0.05);


SELECT * FROM ORDEREMPLOYEE;

/*7.	Increase the price by 10 percent of products containing the words Ink Jet. */
-- BEFORE 
 SELECT * FROM PRODUCT WHERE PRODNAME LIKE '%Ink Jet%';
 
 -- UPDATE 
UPDATE PRODUCT
SET PRODPRICE = PRODPRICE * 1.1
 WHERE PRODNAME LIKE '%Ink Jet%';
 
 
 -- AFTER UPDATE
 SELECT * FROM PRODUCT WHERE PRODNAME LIKE '%Ink Jet%';


/*8.	Delete the new row added to the Customer table.*/
DELETE FROM ORDERCUSTOMER
WHERE CUSTNO = 'C9999999';


SELECT * FROM ORDERCUSTOMER;

/*Que1:For event requests, list the event number, event date (eventrequest.dateheld), 
and count of the event plans.  Only include event requests in the result if the 
event request has more than one related event plan with a work date in December 2013.
*/

SELECT 
      EVENTREQUEST.EVENTNO, DATEHELD, COUNT(*) AS CntEventPlans
FROM 
      EVENTREQUEST inner join EVENTPLAN 
      on EVENTREQUEST.EVENTNO =  EVENTPLAN.EVENTNO 
WHERE 
    WORKDATE BETWEEN '01-DEC-2013' AND '31-DEC-2013'
GROUP BY 
        EVENTREQUEST.EVENTNO, DATEHELD
HAVING COUNT(*) > 1;


/*Ques2: List the plan number, event number, work date, and activity of event plans meeting 
the following two conditions: (1) the work date is in December 2013 and 
(2) the event is held in the “Basketball arena”.  Your query must not use the 
facility number (“F101”) of the basketball arena in the WHERE clause. Instead, 
you should use a condition on the FacName column for the value of “Basketball arena”.*/


SELECT 
      PLANNO, EVENTREQUEST.EVENTNO, WORKDATE,ACTIVITY

FROM EVENTPLAN
inner join EVENTREQUEST 
ON EVENTPLAN.EVENTNO = EVENTREQUEST.EVENTNO
inner join FACILITY 
ON EVENTREQUEST.FACNO = FACILITY.FACNO
WHERE 
    WORKDATE BETWEEN '01-DEC-2013' AND '31-DEC-2013'
    AND FacName  = 'Basketball arena';


/*Que3:List the event number, event date, status, and estimated cost of events 
where there is an event plan managed by Mary Manager and the event is held in the 
basketball arena in the period October 1 to December 31, 2013.  Your query must not 
use the facility number (“F101”) of the basketball arena or the employee number (“E101”) 
of “Mary Manager” in the WHERE clause. Thus, the WHERE clause should not have 
conditions involving the facility number or employee number compared to constant values.
*/

SELECT
      EVENTREQUEST.EVENTNO, DATEHELD, STATUS, ESTCOST
FROM EVENTREQUEST
inner join FACILITY 
ON EVENTREQUEST.FACNO = FACILITY.FACNO
inner join EVENTPLAN
ON EVENTREQUEST.EVENTNO = EVENTPLAN.EVENTNO
inner join EMPLOYEE
ON EVENTPLAN.EMPNO  = EMPLOYEE.EMPNO
WHERE
    EMPNAME = 'Mary Manager' 
    AND DATEHELD BETWEEN '01-OCT-2013' AND '31-DEC-2013'
    AND FACNAME = 'Basketball arena';

/*qu4*/
SELECT 
      EVENTPLAN.PLANNO, LINENO,RESNAME, NUMBERFLD, LOCNAME, TIMESTART, TIMEEND
      
FROM EVENTPLANLINE
    inner join RESOURCETBL 
    on EVENTPLANLINE.RESNO = RESOURCETBL.RESNO
    inner join LOCATION
    on EVENTPLANLINE.LOCNO =  LOCATION.LOCNO
    inner join FACILITY 
    ON LOCATION.FACNO = FACILITY.FACNO
    inner join EVENTPLAN
    ON EVENTPLAN.PLANNO = EVENTPLANLINE.PLANNO
WHERE
    FacName  = 'Basketball arena'
    AND ACTIVITY='Operation'
    AND WORKDATE BETWEEN '01-OCT-2013' AND '31-DEC-2013';
    

/*qu5 Insert a new row into the Facility table with facility name “Swimming Pool”.*/

INSERT INTO FACILITY
(FACNO, FACNAME)
VALUES('F999', 'Swimming Pool');


SELECT * FROM FACILITY;


/*insert  a record*/

INSERT INTO LOCATION
(LOCNO, FACNO, LOCNAME)
VALUES('L991','F999','Locker Room');


SELECT * FROM LOCATION;

/*5.	Delete the row inserted in modification problem 3.*/
DELETE FROM LOCATION
WHERE LOCNO = 'L991';

SELECT * FROM LOCATION ;
