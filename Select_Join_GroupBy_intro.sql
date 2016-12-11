/*1.	List the customer number, the name (first and last), and the balance of customers.*/
SELECT 
      CUSTNO,
      CUSTFIRSTNAME,
      CUSTLASTNAME, 
      CUSTBAL
FROM ORDERCUSTOMER ;

/*2.	List the customer number, the name (first and last), and the balance of
customers who reside in Colorado (CustState is CO).*/
SELECT 
    CUSTNO,
    CUSTFIRSTNAME,
    CUSTLASTNAME,
    CUSTBAL
FROM ORDERCUSTOMER
WHERE CUSTSTATE = 'CO';

/*3.	List all columns of the Product table for products costing more than $50.
Order the result by product manufacturer (ProdMfg) and product name.*/
SELECT 
      * 
FROM PRODUCT 
WHERE PRODPRICE > 50
ORDER BY PRODMFG, PRODNAME ;

/*4.	List the customer number, the name (first and last), the city,
and the balance of customers who reside in Denver with a balance greater 
than $150 or who reside in Seattle with a balance greater than $300.*/
SELECT 
      custno,
      custfirstname,
      custlastname,
      custcity
      
FROM ORDERCUSTOMER
WHERE (custcity = 'Denver' and custbal > 150) or (custcity = 'Seattle' and custbal > 300);


/*5.	List the order number, order date, customer number, and customer name (first and last)
of orders placed in January 2013 sent to Colorado recipients.*/
SELECT 
      ORDNO,
      ORDDATE,
      ORDERTBL.CUSTNO,
      CUSTFIRSTNAME,
      CUSTLASTNAME
FROM ORDERTBL , ORDERCUSTOMER
WHERE ORDERTBL.CUSTNO = ORDERCUSTOMER.CUSTNO
AND (Orddate between '01-JAN-2013' AND '31-JAN-2013') 
AND Ordcity = 'Colorado';


/*6.	List the average balance of customers by city. Include only customers 
residing in Washington state (WA).*/
SELECT 
      CUSTCITY,
      AVG(CUSTBAL) AS AvgCustBal
FROM ORDERCUSTOMER
WHERE CUSTSTATE = 'WA'
GROUP BY CUSTCITY;


/*7.	List the average balance and number of customers by city. Only include 
customers residing in Washington State (WA).  Eliminate cities in the result 
with less than two customers.*/
SELECT 
      CUSTCITY,
      AVG(CUSTBAL) AS AvgCustBal,
      COUNT(distinct custno) as NumCustomers
FROM ORDERCUSTOMER
WHERE CUSTSTATE = 'WA'
GROUP BY CUSTCITY
HAVING  COUNT(distinct custno) > 1;


 


