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
    
    
