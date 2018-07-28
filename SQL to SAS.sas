DATA _NULL_;
LENGTH A C $3;
A=' A';
B=' B';
C=' C';

CONCAT=CAT(A,B,C); PUT CONCAT=;
CONCATS=CATS(A,B,C); PUT CONCATS=;
CONCATT=CAT(A,B,C); PUT CONCATT=;
CONCATX=CATX(' AND ',A,B,C); PUT CONCATX=;
CONCATQ=CATQ(' ' ,A,B,C); PUT CONCATQ=;
/*PROC SORT DATA=Customers;*/
/*BY Country DESCENDING;*/
/*RUN;*/

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Customers;
SHEET=Customers;
RUN;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Categories;
SHEET=Categories;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Employees;
SHEET=Employees;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=OrderDetails;
SHEET=OrderDetails;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Orders;
SHEET=Orders;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Products;
SHEET=Products;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Shippers;
SHEET=Shippers;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Suppliers;
SHEET=Suppliers;


/*****************************SQL SELECT*************************************************/

/*selet * from Customers*/
PROC PRINT DATA=Customers;
RUN;

/*SELECT CustomerName, City FROM Customers;*/
PROC PRINT DATA=Customers;
VAR CustomerName City;
RUN;

/*****************************SQL SELECT DISTINCT*************************************************/
/*SELECT DISTINCT Country FROM Customers;*/
DATA Cust_countries(KEEP=Country);
SET Customers;
PROC SORT DATA=Cust_countries NODUPKEY;
BY Country;
PROC PRINT DATA=Cust_countries;
RUN;

/*SELECT COUNT(DISTINCT Country) FROM Customers;*/

PROC CONTENTS DATA=Cust_countries;
run;
PROC FREQ DATA=Cust_countries;
run;

data _NULL_;
 if 0 then set Cust_countries nobs=n;
 call symputx('totobs',n);
 stop;
run;
%put no. of observations = &totobs;


/*****************************SQL WHERE*************************************************/
/*SELECT * FROM Customers
WHERE Country='Mexico';*/
PROC PRINT DATA=Customers;
WHERE Country='Mexico';
RUN;

DATA c(WHERE=(Country='Mexico'));
SET Customers;
RUN;

/*SELECT * FROM Customers*/
/*WHERE CustomerID=1;*/
PROC PRINT DATA=Customers;
WHERE CustomerID=1;
RUN;

/*****************************SQL AND,OR,NOT*************************************************/
/*SELECT * FROM Customers*/
/*WHERE Country='Germany' AND City='Berlin';*/
PROC PRINT DATA=Customers;
WHERE Country='Germany' AND City='Berlin';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City='Berlin' OR City='München';*/
PROC PRINT DATA=Customers;
WHERE City='Berlin' OR City='München';
RUN;


/*SELECT * FROM Customers*/
/*WHERE NOT Country='Germany';*/
PROC PRINT DATA=Customers;
WHERE Country = 'Germany';
PROC CONTENTS DATA= Customers;
RUN;



/*SELECT * FROM Customers*/
/*WHERE Country='Germany' AND (City='Berlin' OR City='München');*/
PROC PRINT DATA=Customers;
WHERE Country='Germany' AND (City='Berlin' OR City='München');
RUN;


/*SELECT * FROM Customers*/
/*WHERE NOT Country='Germany' AND NOT Country='USA';*/
PROC PRINT DATA=Customers;
WHERE Country NE 'Germany' AND Country NE 'USA';
RUN;

/*Selecting Observations from an Input Data Set*/
DATA c;
SET Customers (WHERE=(Country NE 'Germany' AND Country NE 'USA'));
RUN;

/*Selecting Observations from an Output Data Set*/
DATA c(WHERE=(Country NE 'Germany' AND Country NE 'USA'));
SET Customers;
RUN;


/*****************************SQL ORDER BY*************************************************/
/*SELECT * FROM Customers*/
/*ORDER BY Country;*/
PROC SORT DATA=Customers;
BY Country;
RUN;
PROC PRINT DATA=Customers;
RUN;

/*SELECT * FROM Customers*/
/*ORDER BY Country DESC;*/
PROC SORT DATA=Customers;
BY DESCENDING Country;
RUN;

/*SELECT * FROM Customers*/
/*ORDER BY Country, CustomerName;*/
PROC SORT DATA=Customers;
BY Country CustomerName;
RUN;

/*SELECT * FROM Customers*/
/*ORDER BY Country ASC, CustomerName DESC;*/
PROC SORT DATA=Customers;
BY Country DESCENDING CustomerName;
RUN;


Data have;
input name$;
cards;
AAA
BBB
CCC
DDD
;
run;

DATA have1;
SET have;
output;
if _N_ =3 then do;
   name="C1C1";
   output;
end;
RUN;

/*****************************SQL INSERT INTO*************************************************/
/*INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)*/
/*VALUES ('Cardinal','Tom B. Erichsen','Skagen 21','Stavanger','4006','Norway');*/
DATA Customers1;
SET Customers;
output;
	if _N_ = 91 then do;
	CustomerID=92;
	CustomerName='Cardinal';
	ContactName='Tom B. Erichsen';
	Address='Skagen 21';
	City='Stavanger';
	PostalCode='4006';
	Country='Norway';
	output;
end;
RUN;

/*alternative method*/
data _NULL_;
 if 0 then set Customers nobs=n;
 call symputx('totobs',n);
 stop;
run;
/*To display in LOG(Untitled) window*/
%put no. of observations = &totobs;

DATA Customers1;
SET Customers;
output;
	if _N_ = &totobs then do; /*checking for the last observation*/
	CustomerID= &totobs+1; /*making the id+1*/
	CustomerName='Cardinal';
	ContactName='Tom B. Erichsen';
	Address='Skagen 21';
	City='Stavanger';
	PostalCode='4006';
	Country='Norway';
	output;
end;
RUN;

/*INSERT INTO Customers (CustomerName, City, Country)*/
/*VALUES ('Cardinal', 'Stavanger', 'Norway');*/
data _NULL_;
 if 0 then set Customers1 nobs=n;
 call symputx('totobs',n);
 stop;
run;
/*To display in LOG(Untitled) window*/
%put no. of observations = &totobs;
DATA Customers2;
SET Customers1;
output;
	if _N_ = &totobs then do; /*checking for the last observation*/
	CustomerID= &totobs+1; /*making the id+1*/
	CustomerName='Asdf';
	City='Asdf';
	Country='Asdf';
	output;
end;
RUN;

/*****************************SQL NULL VALUES*************************************************/
/*CHECK THE BELOW FOR SETTING NULL AS EMPTY*/
DATA Customers2;
SET Customers1;
output;
	if _N_ = &totobs then do; /*checking for the last observation*/
	CustomerID= &totobs+1; /*making the id+1*/
	CustomerName='Cardinal';
	ContactName='';
	Address='';
	City='Stavanger';
	PostalCode='';
	Country='Norway';
	output;
end;
RUN;

/*SELECT LastName, FirstName, Address FROM Persons*/
/*WHERE Address IS NULL;*/
PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=Persons;
SHEET=Persons;
RUN;

DATA per(KEEP=LastName FirstName Address 
		 WHERE=(Address=''));
SET Persons;
RUN;

/*SELECT LastName, FirstName, Address FROM Persons*/
/*WHERE Address IS NOT NULL;*/
DATA per1(KEEP=LastName FirstName Address 
		 WHERE=(Address NE ''));
SET Persons;
RUN;

/*****************************SQL UPDATE*************************************************/

/*UPDATE Customers*/
/*SET ContactName='Alfred Schmidt', City='Frankfurt'*/
/*WHERE CustomerID=1;*/

DATA Customers2;
SET Customers;
IF CustomerID=1 THEN 
	DO;
		ContactName='asdf';
		City='asdf';
	END;
RUN;

/*UPDATE Customers*/
/*SET ContactName='Juan'*/
/*WHERE Country='Mexico';*/

DATA Customers2;
SET Customers2;
IF Country='Mexico' THEN 
	DO;
		ContactName='Juan';
	END;
RUN;


/*DATA Customers3 (WHERE=(Country='Mexico'));*/
/*ContactName='aSDF';*/
/*SET Customers2;*/
/*RUN;*/


/*UPDATE Customers*/
/*SET ContactName='Juan';*/
DATA Customers3;
SET Customers2;
 ContactName='Juan';
RUN;


/*****************************SQL DELETE*************************************************/

/*DELETE FROM Customers*/
/*WHERE CustomerName='Alfreds Futterkiste';*/

DATA Customers2;
MODIFY Customers2;
IF CustomerName='Alfreds Futterkiste' THEN REMOVE;
RUN;


/*DATA _NULL_;
 IF 0 THEN SET Customers2 NOBS=n;
 CALL SYMPUTX('totobs',n);
 STOP;
RUN;
%PUT obs_count=&totobs;

PROC CONTENTS DATA=Customers2;
RUN;*/

/*DELETE FROM table_name;*/
/*DELETE * FROM table_name;*/
DATA Customers2;
MODIFY Customers2;
REMOVE;
run;

/*****************************SQL SELECT TOP*************************************************/

/*SELECT TOP 3 * FROM Customers;*/
DATA Customers4;
SET Customers2(OBS=3);
RUN;


/*MACRO to get total no of observation - SYED*/
%macro GetObservationCount(d=,p=);
DATA _NULL_;
	IF 0 THEN SET &d. NOBS=n;
	CALL SYMPUTX('result',n);
	STOP;
RUN;

%PUT Total Observation Count =%sysfunc(round(%sysevalf(&result.*(&p./100))));
%mend GetObservationCount;
%GetObservationCount(d=Customers,p=50);




/*%sysevalf((&result.*(&p./100)),integer);*/
/**/
/**/
/*%IF( (%sysevalf((&result.*(&p./100))/(&result.*(&p./100)),integer))) */
/*%PUT FLOOR*/
/*%ELSE */
/*%PUT CEIL*/


/*MACRO - Internet Source*/

%macro totobs(mydata,p);
    %let mydataID=%sysfunc(OPEN(&mydata.,IN)); /*The OPEN function is used to open a data*/
    %let NOBS=%sysfunc(ATTRN(&mydataID,NOBS)); /*The ATTRN function returns the value of a numeric attribute for a SAS data set. When it is used with the NOBS argument, it returns the number of observations.*/
    %let RC=%sysfunc(CLOSE(&mydataID)); /*We are closing the opened dataset using CLOSE function.*/
	%sysfunc(ROUND(%sysevalf(&NOBS*(&p./100))));
%mend;


/*SELECT TOP 50 PERCENT * FROM Customers;*/
%let value=%totobs(Customers,50);
%put &Value.;
/*%let a=14;*/
/*%put &a.;*/
/*%let a=%SYSEVALF(%totobs(Customers,10),integer);*/
DATA Cust50;
SET Customers(OBS=&value.);
RUN;

/*****************************SQL MIN & MAX*************************************************/

/*SELECT MIN(Price) AS SmallestPrice*/
/*FROM Products; */
PROC MEANS DATA=Products NOPRINT;
	VAR Price;
	OUTPUT OUT=result 	MIN(Price)=Min_Price;
PROC PRINT DATA=result;
RUN;

/*SELECT MAX(Price) AS LargestPrice*/
/*FROM Products; */

PROC MEANS DATA=Products NOPRINT;
	VAR Price;
	OUTPUT OUT=result1 
		MAX(Price)=Max_Price;
PROC PRINT DATA=result1;
RUN;

/*SELECT MAX(Price) AS LargestPrice, MIN(Price) AS SmallestPrice*/
/*FROM Products; */

PROC MEANS DATA=Products NOPRINT;
	VAR Price;
	OUTPUT OUT=Result3 
		MIN(Price)=SmallestPrice
		MAX(Price)=LargestPrice;

PROC PRINT DATA=Result3;
RUN;

PROC MEANS DATA=Products;
RUN;


/*****************************SQL COUNT, AVG, SUM*************************************************/

/*SELECT COUNT(ProductID)*/
/*FROM Products;*/

PROC MEANS DATA=Products NOPRINT;
	VAR ProductID;
	OUTPUT OUT=Result4
		N(ProductID)=COUNT_ProductID;
PROC PRINT DATA=Result4;
RUN;


/*SELECT AVG(Price)*/
/*FROM Products;*/

PROC MEANS DATA=Products NOPRINT;
	VAR Price;
	OUTPUT OUT=Result5
		MEAN(Price)=AVG_Price;
PROC PRINT DATA=Result5;
RUN;


/*SELECT SUM(Quantity)*/
/*FROM OrderDetails;*/

PROC MEANS DATA=OrderDetails NOPRINT;
	VAR Quantity;
	OUTPUT OUT=Result6
		SUM(Quantity)=SUM_Quantity;
PROC PRINT DATA=Result6;
RUN;


/*****************************SQL LIKE*************************************************/

/*SELECT * FROM Customers*/
/*WHERE CustomerName LIKE 'a%';*/

DATA C1;
SET Customers;
	WHERE CustomerName LIKE 'A%';
RUN;

/*SELECT * FROM Customers*/
/*WHERE CustomerName LIKE '%a';*/

DATA C2;
SET Customers;
	WHERE CustomerName LIKE '%a';
RUN;


/*SELECT * FROM Customers*/
/*WHERE CustomerName LIKE '%or%'*/

DATA C3;
SET Customers;
	WHERE CustomerName LIKE '%or%';
RUN;


/*SELECT * FROM Customers*/
/*WHERE CustomerName LIKE '_r%';*/

DATA C4;
SET Customers;
	WHERE CustomerName LIKE '_r%' OR CustomerName LIKE '_R%';
RUN;

/*SELECT * FROM Customers*/
/*WHERE CustomerName LIKE 'a_%_%';*/


DATA C5;
SET Customers;
	WHERE CustomerName LIKE 'a_%_%' OR CustomerName LIKE 'A_%_%';
RUN;


/*SELECT * FROM Customers*/
/*WHERE ContactName LIKE 'a%o';*/

DATA C6;
SET Customers;
	WHERE ContactName LIKE 'a%o' OR 
		  ContactName LIKE 'A%o' OR
		  ContactName LIKE 'a%O' OR
		  ContactName LIKE 'A%O';
RUN;


/*SELECT * FROM Customers*/
/*WHERE CustomerName NOT LIKE 'a%';*/

DATA C7;
SET Customers;
	WHERE lowcase(CustomerName) NOT LIKE 'a%';
RUN;

/*****************************SQL WILDCARDS*************************************************/

/*SELECT * FROM Customers*/
/*WHERE City LIKE 'ber%';*/

DATA C8;
SET Customers;
	WHERE LOWCASE(City) LIKE 'ber%';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City LIKE '%es%';*/

DATA C9;
SET Customers;
	WHERE LOWCASE(City) LIKE '%es%';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City LIKE '_erlin';*/

DATA C10;
SET Customers;
	WHERE LOWCASE(City) LIKE '_erlin';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City LIKE 'L_n_on';*/

DATA C11;
SET Customers;
	WHERE LOWCASE(City) LIKE 'l_n_on';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City LIKE '[bsp]%';*/

DATA C12;
SET Customers;
	WHERE  LOWCASE(City) LIKE 'b%'
		OR LOWCASE(City) LIKE 's%'
		OR LOWCASE(City) LIKE 'p%';
RUN;


/*SELECT * FROM Customers*/
/*WHERE City LIKE '[a-c]%';*/

DATA C13;
SET Customers;
	WHERE  LOWCASE(City) LIKE 'a%'
		OR LOWCASE(City) LIKE 'b%'
		OR LOWCASE(City) LIKE 'c%';
RUN;

/*DATA C14;*/
/*SET Customers;*/
/*	WHERE LOWCASE(City) LIKE IN ('a%','b%','c%');*/
/*RUN;*/


/*SELECT * FROM Customers*/
/*WHERE City LIKE '[!bsp]%';*/

/*SELECT * FROM Customers*/
/*WHERE City NOT LIKE '[bsp]%';*/

DATA C14;
SET Customers;
	WHERE  LOWCASE(City) NOT LIKE 'b%'
		AND LOWCASE(City) NOT LIKE 's%'
		AND LOWCASE(City) NOT LIKE 'p%';
RUN;

/*****************************SQL IN*************************************************/


/*SELECT * FROM Customers*/
/*WHERE Country IN ('Germany', 'France', 'UK');*/

DATA C15;
SET Customers;
	WHERE Country IN ('Germany', 'France', 'UK');
RUN;

/*SELECT * FROM Customers*/
/*WHERE Country NOT IN ('Germany', 'France', 'UK');*/

DATA C16;
SET Customers;
	WHERE Country NOT IN ('Germany', 'France', 'UK');
RUN;

/*SELECT * FROM Customers*/
/*WHERE Country IN (SELECT Country FROM Suppliers);*/

/*DATA S;*/
/*SET Suppliers (KEEP=Country);*/
/*RUN;*/

PROC SORT DATA = Customers;
BY Country;
PROC SORT DATA = Suppliers;
BY Country;
/*INCORRECT*/
DATA C17;
MERGE Customers S(IN=CheckCountry);
BY Country;
IF CheckCountry=1;
RUN;
/*CORRECT*/
DATA C18;
MERGE Customers(IN=C_Country) Suppliers(IN=S_Country);
BY Country;
IF C_Country=1 AND S_Country=1;
RUN;

/*****************************SQL BETWEEN*************************************************/

/*SELECT * FROM Products*/
/*WHERE Price BETWEEN 10 AND 20;*/

DATA P1;
SET Products;
	WHERE Price BETWEEN 10 AND 20;
RUN;

/*SELECT * FROM Products*/
/*WHERE Price NOT BETWEEN 10 AND 20;*/

DATA P2;
SET Products;
	WHERE Price NOT BETWEEN 10 AND 20;
RUN;

/*SELECT * FROM Products*/
/*WHERE (Price BETWEEN 10 AND 20)*/
/*AND NOT CategoryID IN (1,2,3);*/

DATA P3;
SET Products;
	WHERE 	Price BETWEEN 10 AND 20
			AND
			CategoryID NOT IN (1,2,3) ;
RUN;

/*SELECT * FROM Products*/
/*WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'*/
/*ORDER BY ProductName;*/

DATA P4;
SET Products;
	WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni';
PROC SORT DATA = P4;
BY ProductName;
RUN;


/*SELECT * FROM Products*/
/*WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'*/
/*ORDER BY ProductName;*/

DATA P5;
SET Products;
	WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni';
PROC SORT DATA = P5;
BY ProductName;
RUN;


/*SELECT * FROM Orders*/
/*WHERE OrderDate BETWEEN #07/04/1996# AND #07/09/1996#;*/

DATA P6;
SET Orders;
/*	FORMAT OrderDate MMDDYY10.;*/
	WHERE OrderDate BETWEEN '04JUL1996'd AND '09JUL1996'd;
RUN;


/*DATA P7;*/
/*SET P6;*/
/*	IF (OrderDate GT '07/04/1996'd AND  OrderDate LT '07/09/1996'd);*/
/*RUN; */


/*****************************SQL ALAISES*************************************************/

/*SELECT CustomerID as ID, CustomerName AS Customer*/
/*FROM Customers;*/

/*not required*/
DATA C2(DROP=CustomerID CustomerName );
RETAIN ID Customer ContactName Address City PostalCode Country; /*To change the order of the variable*/
SET Customers;
ID=CustomerID;
Customer=CustomerName;
RUN;


DATA C3(KEEP=ID Customer);
SET Customers;
ID=CustomerID;
Customer=CustomerName;
RUN;


/*SELECT CustomerName AS Customer, ContactName AS [Contact Person]*/
/*FROM Customers;*/

DATA C4(KEEP= Customer Contact_Person); /*Cannot have space in between the variable name*/
SET Customers;
Customer=CustomerName;
Contact_Person=ContactName;
RUN;


/*SELECT CustomerName, Address + ', ' + PostalCode + ' ' + City + ', ' + Country AS Address*/
/*FROM Customers;*/

DATA C5(KEEP = CustomerName Address );
SET Customers;
Address= STRIP(Address) || ', ' || STRIP(PostalCode) || ' '  || STRIP(City) || ', ' || STRIP(Country) ;
*Add= CAT(Address,  PostalCode ,  City , Country);
RUN;

/*TESTING CONCAT*/
/*
DATA A;
LENGTH A C $3;
A=' A';
B=' B';
C=' C';

CONCAT=CAT(A,B,C); PUT CONCAT=;
CONCATS=CATS(A,B,C); PUT CONCATS=;
CONCATT=CAT(A,B,C); PUT CONCATT=;
CONCATX=CATX(' AND ',A,B,C); PUT CONCATX=;
CONCATQ=CATQ(' ' ,A,B,C); PUT CONCATQ=;

RUN;
*/

/*SELECT o.OrderID, o.OrderDate, c.CustomerName*/
/*FROM Customers AS c, Orders AS o*/
/*WHERE c.CustomerName="Around the Horn" AND c.CustomerID=o.CustomerID;*/

PROC SORT DATA=Customers;
BY CustomerID;
PROC SORT DATA=Orders;
BY CustomerID;
DATA CO (KEEP =OrderID OrderDate CustomerName);
MERGE Customers(IN=Ccid) Orders(IN=Ocid);
BY CustomerID;
IF Ccid=1 AND Ocid=1 AND CustomerName="Around the Horn" ;
RUN;



/*****************************SQL JOINS*************************************************/

/*SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate*/
/*FROM Orders*/
/*INNER JOIN Customers*/
/*ON Orders.CustomerID=Customers.CustomerID;*/

DATA CO1(KEEP= OrderID CustomerName OrderDate );
MERGE Customers(IN=Ccid) Orders(IN=Ocid);
BY CustomerID;
IF Ccid=1 AND Ocid=1 ;

PROC SORT DATA=CO1;
BY OrderID;
RUN;


/*****************************SQL INNER JOIN*************************************************/

/*SELECT Orders.OrderID, Customers.CustomerName*/
/*FROM Orders*/
/*INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;*/


DATA CO2(KEEP= OrderID CustomerName );
MERGE Customers(IN=Ccid) Orders(IN=Ocid);
BY CustomerID;
IF Ccid AND Ocid;

PROC SORT DATA=CO2;
BY OrderID;
RUN;


/*SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName*/
/*FROM ((Orders*/
/*INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)*/
/*INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);*/

PROC SORT DATA=Customers;
BY CustomerID;

PROC SORT DATA=Orders;
BY CustomerID;

DATA OC;
MERGE Customers(IN=Ccid) Orders(IN=Ocid);
BY CustomerID;
IF Ccid AND Ocid;

PROC SORT DATA=OC;
BY ShipperID;

PROC SORT DATA=Shippers;
BY ShipperID;

DATA SOC(KEEP = OrderID CustomerName ShipperName);
MERGE OC(IN=OCsid) Shippers(IN=Ssid);
BY ShipperID;
IF OCsid AND Ssid;

PROC SORT DATA = SOC;
BY OrderID;

RUN;


/*****************************SQL LEFT JOIN*************************************************/

/*SELECT Customers.CustomerName, Orders.OrderID*/
/*FROM Customers*/
/*LEFT JOIN Orders*/
/*ON Customers.CustomerID=Orders.CustomerID*/
/*ORDER BY Customers.CustomerName;*/


DATA LFT(KEEP=CustomerName OrderID );
MERGE Customers (IN=Ccid) Orders (IN=Ocid);
BY CustomerID;
IF Ccid;

PROC SORT DATA=LFT;
BY CustomerName;

RUN;


/*****************************SQL RIGHT JOIN*************************************************/

/*SELECT Orders.OrderID, Employees.LastName, Employees.FirstName*/
/*FROM Orders*/
/*RIGHT JOIN Employees*/
/*ON Orders.EmployeeID = Employees.EmployeeID*/
/*ORDER BY Orders.OrderID;*/

PROC SORT DATA = Orders;
BY EmployeeID;

PROC SORT DATA=Employees;
BY EmployeeID;

DATA RHT (KEEP= OrderID LastName FirstName);
MERGE Orders(IN=Oeid) Employees(IN=Eeid);
BY EmployeeID;
IF Eeid;

PROC SORT DATA=RHT;
BY OrderID;

RUN;


/*****************************SQL FULL JOIN*************************************************/

/*SELECT Customers.CustomerName, Orders.OrderID*/
/*FROM Customers*/
/*FULL OUTER JOIN Orders ON Customers.CustomerID=Orders.CustomerID*/
/*ORDER BY Customers.CustomerName;*/

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=C1;
SHEET=C1;
RUN;

PROC IMPORT DATAFILE='C:\Users\448513\Documents\My SAS Files\DB1.xls' OUT=O1;
SHEET=O1;
RUN;


PROC SORT DATA=C1;
BY CustomerID;

PROC SORT DATA=O1;
BY CustomerID;

DATA F2(KEEP= CustomerName OrderID );
MERGE C1(IN=Ccid) O1 (IN=Ocid);
BY CustomerID;

PROC SORT DATA=F2;
BY CustomerName;

RUN;

/*****************************SQL SELF JOIN*************************************************/

/*SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City*/
/*FROM Customers A, Customers B*/
/*WHERE A.CustomerID <> B.CustomerID*/
/*AND A.City = B.City */
/*ORDER BY A.City;*/


PROC SORT DATA= Customers;
BY CustomerID;

DATA A;
SET Customers;

DATA B;
SET Customers;

PROC SORT DATA= Customers;
BY City;

DATA C;
SET Customers;

DATA D;
SET Customers;

DATA CID;
MERGE A(IN=Acid) B(IN=Bcid);
BY CustomerID;
IF Acid=0 AND Bcid=0;
RUN;

/*****************************SQL UNION*************************************************/

PROC SORT DATA= Customers;
BY City;


PROC SORT DATA= Suppliers;
BY City;


DATA C(KEEP = City);  /*UNION ALL*/
SET Customers Suppliers;
BY City;

PROC SORT DATA=C NODUPKEY; /*UNION*/
BY City;
RUN;


/*SELECT City, Country FROM Customers*/
/*WHERE Country='Germany'*/
/*UNION*/
/*SELECT City, Country FROM Suppliers*/
/*WHERE Country='Germany'*/
/*ORDER BY City;*/

/*Since above statement is UNION so unique data has to be present*/

DATA C1(KEEP = City Country);
SET Customers Suppliers;
	WHERE Country = 'Germany';

PROC SORT DATA=C1 NODUPKEY; 
BY City;

RUN;


/*SELECT City, Country FROM Customers*/
/*WHERE Country='Germany'*/
/*UNION ALL*/
/*SELECT City, Country FROM Suppliers*/
/*WHERE Country='Germany'*/
/*ORDER BY City;*/

DATA C2(KEEP = City Country);
SET Customers Suppliers;
	WHERE Country = 'Germany';
RUN;

/*SELECT 'Customer' As Type, ContactName, City, Country*/
/*FROM Customers*/
/*UNION*/
/*SELECT 'Supplier', ContactName, City, Country*/
/*FROM Suppliers*/


DATA C3(KEEP = TYPE ContactName City Country);
SET Customers(in=a) Suppliers(in=b);
if a then TYPE='Customers';
Else TYPE='Suppliers';
/*DATA C4(KEEP = TYPE ContactName City Country);*/
/*SET Suppliers;*/
/*TYPE='Suppliers';*/

/*DATA C5;*/
/*RETAIN TYPE ContactName City Country;*/
/*SET C3 C4;*/
RUN;







/*****************************SQL GROUP BY*************************************************/


/*SELECT COUNT(CustomerID), Country*/
/*FROM Customers*/
/*GROUP BY Country;*/


/*PROC TABULATE DATA=Customers;*/
/*CLASS  Country CustomerID;*/
/*TABLE Country,CustomerID;*/
/*RUN; */


PROC MEANS NOPRINT DATA=Customers;
CLASS Country;
VAR CustomerID;
OUTPUT OUT = R
	N(CustomerID)=COUNT_CustomerID;

/*SELECT COUNT(CustomerID), Country*/
/*FROM Customers*/
/*GROUP BY Country*/
/*ORDER BY COUNT(CustomerID) DESC;*/

PROC SORT DATA=R;
BY DESCENDING _FREQ_;
RUN;

/*****************************SQL HAVING*************************************************/

/*SELECT COUNT(CustomerID), Country*/
/*FROM Customers*/
/*GROUP BY Country*/
/*HAVING COUNT(CustomerID) > 5;*/

/*SELECT COUNT(CustomerID), Country*/
/*FROM Customers*/
/*GROUP BY Country*/
/*HAVING COUNT(CustomerID) > 5*/
/*ORDER BY COUNT(CustomerID) DESC;*/

PROC SORT DATA=R;
BY DESCENDING _FREQ_;
WHERE _FREQ_>5;
RUN;


/*SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders*/
/*FROM (Orders*/
/*INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID)*/
/*GROUP BY LastName*/
/*HAVING COUNT(Orders.OrderID) > 10;*/


PROC SORT DATA= Orders;
BY EmployeeID;

PROC SORT DATA=Employees;
BY EmployeeID;

DATA R1(KEEP= LastName OrderID);
MERGE Orders(IN = Oeid ) Employees (IN = Eeid);
BY EmployeeID;
IF Oeid && Eeid;

PROC MEANS NOPRINT DATA=R1;
CLASS LastName;
VAR OrderID;
OUTPUT OUT = R2
	N(OrderID)= NumberOfOrders
;

PROC SORT DATA=R2;
BY LastName;
WHERE NumberOfOrders>10;

RUN;


/*SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders*/
/*FROM Orders*/
/*INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID*/
/*WHERE LastName = 'Davolio' OR LastName = 'Fuller'*/
/*GROUP BY LastName*/
/*HAVING COUNT(Orders.OrderID) > 25;*/

PROC SORT DATA= Orders;
BY EmployeeID;

PROC SORT DATA=Employees;
BY EmployeeID;

DATA R1(KEEP= LastName OrderID);
MERGE Orders(IN = Oeid ) Employees (IN = Eeid);
BY EmployeeID;
IF Oeid && Eeid;

PROC MEANS NOPRINT DATA=R1;
CLASS LastName;
VAR OrderID;
OUTPUT OUT = R3
	N(OrderID)= NumberOfOrders
;

PROC SORT DATA=R3;
BY LastName;
WHERE LastName='Davolio' OR LastName='Fuller' 
		AND 
	  NumberOfOrders>25;

RUN;



/*****************************SQL EXISTS*************************************************/


/*SELECT SupplierName*/
/*FROM Suppliers*/
/*WHERE EXISTS (SELECT ProductName FROM Products WHERE SupplierId = Suppliers.supplierId AND Price < 20);*/


DATA R4(KEEP = supplierId Price );
SET Products;
IF Price<20;

PROC SORT DATA=R4 NODUPKEY;
BY supplierId;
/*WHERE Price<20;*/

PROC SORT DATA = Suppliers;
BY SupplierId;

DATA R5(KEEP = SupplierName);
MERGE Suppliers(IN= Ssid ) R4(IN= R4sid);
BY supplierId;
IF Ssid AND R4sid;
RUN;


/*SELECT SupplierName*/
/*FROM Suppliers*/
/*WHERE EXISTS (SELECT ProductName FROM Products WHERE SupplierId = Suppliers.supplierId AND Price = 22);*/

DATA R6(KEEP = SupplierId);
SET Products;
WHERE Price=22;

/*NO DUPLICATE AND SORTING SHOULD BE INCLUDED*/

DATA R7(KEEP= SupplierName);
MERGE Suppliers (IN = Ssid) R6 (IN= R6sid);
BY SupplierId;
IF Ssid AND R6sid;
RUN;

/*****************************SQL ANY, ALL*************************************************/

/*SELECT ProductName*/
/*FROM Products*/
/*WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);*/

DATA R8(KEEP = ProductID);
SET OrderDetails;
IF Quantity=10;

PROC SORT DATA=R8 NODUPKEY;
BY ProductID;

PROC SORT DATA=Products;
BY ProductID;

DATA R9(KEEP= ProductName);
MERGE R8(IN=R8pid) Products(IN=Ppid) ;
BY ProductID;
IF R8pid && Ppid;

RUN;


/*SELECT ProductName*/
/*FROM Products*/
/*WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity > 99);*/


DATA R10(KEEP = ProductID);
SET OrderDetails;
IF Quantity>99;

PROC SORT DATA=R10 NODUPKEY;
BY ProductID;

PROC SORT DATA=Products;
BY ProductID;

DATA R11(KEEP= ProductName);
MERGE Products(IN=Ppid) R10(IN= R10pid);
BY ProductID;
IF Ppid && R10pid;

RUN;

/*SELECT ProductName */
/*FROM Products*/
/*WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);*/


/*****************************SQL SELECT INTO*************************************************/

/*SELECT * INTO CustomersBackup2017*/
/*FROM Customers;*/

DATA CustomersBackup2017;
SET Customers;


/*SELECT * INTO CustomersBackup2017 IN 'Backup.mdb'*/
/*FROM Customers;*/

LIBNAME Backup 'C:\Users\448513\Documents\My SAS Files';
DATA Backup.CustomersBackup2017;
SET Customers;


/*SELECT CustomerName, ContactName INTO CustomersBackup2017*/
/*FROM Customers;*/

DATA CustomersBackup2017(KEEP= CustomerName ContactName);
SET Customers;


/*SELECT * INTO CustomersGermany*/
/*FROM Customers*/
/*WHERE Country = 'Germany';*/


DATA CustomersGermany;
SET Customers;
IF Country = 'Germany';


/*SELECT Customers.CustomerName, Orders.OrderID*/
/*INTO CustomersOrderBackup2017*/
/*FROM Customers*/
/*LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID;*/


PROC SORT DATA=Customers;
BY CustomerID;

PROC SORT DATA=Orders;
BY CustomerID;

DATA CustomersOrderBackup2017(KEEP = CustomerName  OrderID);
MERGE Customers (IN= Ccid) Orders (IN= Ocid);
BY CustomerID;
IF Ccid;

RUN;
/*****************************SQL INSERT INTO SELECT*************************************************/

/*INSERT INTO Customers (CustomerName, City, Country)*/
/*SELECT SupplierName, City, Country FROM Suppliers;*/



DATA Customers1(KEEP = CustomerID CustomerName ContactName Address City PostalCode Country);
SET Customers(IN=c) Suppliers(IN=s KEEP = SupplierName City Country);
IF s THEN 
DO;
	CustomerName = SupplierName ;
	City = City;
	Country = Country;
END;
RUN;


/*INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)*/
/*SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM Suppliers;*/


DATA Customers2 (KEEP = CustomerID CustomerName ContactName Address City PostalCode Country);
SET Customers(IN = c) Suppliers (IN=s KEEP= SupplierName ContactName Address City PostalCode Country);
IF s THEN;
DO;
	CustomerName=SupplierName;
	ContactName=ContactName;
	Address=Address;
	City=City;
	PostalCode=PostalCode;
	Country=Country;
END;
RUN;

/*INSERT INTO Customers (CustomerName, City, Country)*/
/*SELECT SupplierName, City, Country FROM Suppliers*/
/*WHERE Country='Germany';*/

%LET CustomersVariables = CustomerID CustomerName ContactName Address City PostalCode Country;
DATA Customers3(KEEP = &CustomersVariables );
SET Customers( IN=C) 
	Suppliers( IN=S 
			   KEEP= SupplierName City Country 
			   WHERE= (Country='Germany') 
			 );
/*WHERE Country='Germany'; IT IS TAKING COMMON FOR BOTH*/
IF S THEN;
DO;
	CustomerName=SupplierName;
	City=City;
	Country=Country;
END;

RUN;



/*****************************SQL NULL FUNCTIONS*************************************************/
/*****************************SQL STORED PROCEDURES*************************************************/

/*CREATE PROCEDURE SelectAllCustomers*/
/*AS*/
/*SELECT * FROM Customers*/
/*GO;*/

%MACRO SelectAllCustomers;
PROC PRINT DATA=Customers;
%MEND SelectAllCustomers;

/*EXEC SelectAllCustomers;*/

%SelectAllCustomers;
RUN;

/*****************************SQL COMMENTS*************************************************/
