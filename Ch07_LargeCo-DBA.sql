#Write a query to display the eight departments in the LGDEPARTMENT table sorted by department name.
select *
from LGDEPARTMENT
order by DEPT_NAME;


#Write a query to display the SKU (stock keeping unit), description, type, base, category,
#and price for all products that have a PROD_BASE of Water and a PROD_CATEGORY of Sealer (Figure P7.28).
select PROD_SKU, PROD_DESCRIPT, PROD_TYPE, PROD_BASE,PROD_CATEGORY, PROD_PRICE
from LGPRODUCT
where PROD_BASE='Water' and PROD_CATEGORY='Sealer';

#Write a query to display the first name, last name, and email address of employees hired from May 1, 2011,
#to December 31, 2012. Sort the output by last name and then by first name (partial results shown in Figure P7.29).
select  EMP_FNAME,EMP_LNAME,EMP_EMAIL
from LGEMPLOYEE
where EMP_HIREDATE between '2005-01-01' and '2014-12-31'
order by 2,1;

#Write a query to display the first name, last name, phone number, title, and department number of employees who work in department 300 
#or have the title “CLERK I.” Sort the output by last name and then by first name (partial results shown in Figure P7.30).
select EMP_FNAME,EMP_LNAME,EMP_PHONE,EMP_TITLE, DEPT_NUM
from LGEMPLOYEE 
where DEPT_NUM=300 or EMP_TITLE = 'CLERK I'
order by 2,1;


#Write a query to display the employee number, last name, first name, salary “from” date, salary end date, 
#and salary amount for employees 83731, 83745, and 84039. Sort the output by employee number and salary “from” date (Figure P7.31).
SELECT EMP.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_FROM, SAL_END, SAL_AMOUNT
FROM LGEMPLOYEE EMP JOIN LGSALARY_HISTORY SAL ON EMP.EMP_NUM = SAL.EMP_NUM
WHERE EMP.EMP_NUM In (83731, 83745, 84039)
ORDER BY EMP.EMP_NUM, SAL_FROM;


#Write a query to display the first name, last name, street, city, state, and zip code of any customer who purchased a 
#Foresters Best brand top coat between July 15, 2021, and July 31, 2021. If a customer purchased more than one such product, 
#display the customer’s information only once in the output. Sort the output by state, last name, and then first name (Figure P7.32).
select distinct CUST_FNAME,CUST_LNAME,CUST_STREET,CUST_CITY,
CUST_STATE,
CUST_ZIP
from LGCUSTOMER c join LGINVOICE i 
on c.CUST_CODE=i.CUST_CODE
join LGLINE l
on i.INV_NUM=l.INV_NUM
join LGPRODUCT p
on p.PROD_SKU=l.PROD_SKU
join LGBRAND b
on p.BRAND_ID=b.BRAND_ID
where i.INV_DATE between '2021-07-15' and '2021-07-31' 
and b.BRAND_NAME='FORESTERS BEST' 
and p.PROD_CATEGORY='Top Coat'
order by CUST_STATE,CUST_LNAME,CUST_FNAME;


#Write a query to display the employee number, last name, email address, title, and department name of each employee whose job title ends in 
#the word “ASSOCIATE.” Sort the output by department name, employee title, and employee number (Partial result shown in Figure P7.33).
select e.EMP_NUM, EMP_LNAME, EMP_EMAIL, EMP_TITLE, 
DEPT_NAME
from LGEMPLOYEE e join LGDEPARTMENT d 
on e.DEPT_NUM=d.DEPT_NUM
where EMP_TITLE like '%ASSOCIATE'
order by 5,4,1;


#Write a query to display a brand name and the number of products of that brand that are in the database. 
#Sort the output by the brand name (Figure P7.34).
select b.BRAND_NAME, count(p.PROD_SKU) as NUMPRODUCTS
from LGBRAND b inner join LGPRODUCT p 
on b.BRAND_ID=p.BRAND_ID
group by 1
order by 1;


#Write a query to display the number of products in each category that have a water base, sorted by category (Figure P7.35).
select PROD_CATEGORY, count(*) as NUMPRODUCTS
from LGPRODUCT
where PROD_BASE='Water'
group by 1
order by 1;

#Write a query to display the number of products within each base and type combination, sorted by base and then by type (Figure P7.36).
select PROD_BASE, PROD_TYPE, count(*) as NUMPRODUCTS
from LGPRODUCT
group by 1,2
order by 1,2;


#Write a query to display the total inventory—that is, the sum of all products on hand for each brand ID. Sort the output by brand ID in descending order (Figure P7.37).
select BRAND_ID,sum(PROD_QOH) as TOTALINVENTORY
from LGPRODUCT
group by 1
order by 1 desc;

#Write a query to display the brand ID, brand name, and average price of products of each brand. Sort the output by brand name.
#Results are shown with the average price rounded to two decimal places (Figure P7.38).
select p.BRAND_ID, BRAND_NAME,ROUND(avg(PROD_PRICE),2) as AVGPRICE
from LGPRODUCT p join LGBRAND b 
on p.BRAND_ID=b.BRAND_ID
group by 1,2
order by 2;

#Write a query to display the department number and most recent employee hire date for each department.
#Sort the output by department number (Figure P7.39).
select DEPT_NUM, max(EMP_HIREDATE) as MOSTRECENT
from LGEMPLOYEE
group by 1
order by 1;

#Write a query to display the employee number, first name, last name, and largest salary amount for each employee in department 200. 
#Sort the output by largest salary in descending order, and then by employee number (Partial results shown in Figure P7.40).
select e.EMP_NUM, EMP_FNAME, EMP_LNAME, max(SAL_AMOUNT)
as LARGESTSALARY
from LGEMPLOYEE e join LGSALARY_HISTORY s
on e.EMP_NUM=s.EMP_NUM
where DEPT_NUM=200
group by 1,2,3
order by 4 desc, 1;


#Write a query to display the customer code, first name, last name, and sum of all invoice totals for customers 
#with cumulative invoice totals greater than $1,500. 
#Sort the output by the sum of invoice totals in descending order (Partial results shown in Figure P7.41).
select c.CUST_CODE, CUST_FNAME, CUST_LNAME,sum(INV_TOTAL)
as TOTALINVOICES
from LGCUSTOMER c join LGINVOICE i
on c.CUST_CODE=i.CUST_CODE
group by 1,2,3
having sum(INV_TOTAL)>1500
order by 4 desc;


#Write a query to display the department number, department name,
#department phone number, employee number, and last name of each department manager. Sort the output by department name (Figure P7.42).
select d.DEPT_NUM,DEPT_NAME,DEPT_PHONE,d.EMP_NUM,EMP_LNAME
from LGEMPLOYEE e inner join LGDEPARTMENT d 
on e.EMP_NUM=d.EMP_NUM
order by 2;


#Write a query to display the vendor ID, vendor name, brand name, and number of products of each brand supplied by each vendor.
#Sort the output by vendor name and then by brand name (Partial results shown in Figure P7.43).
select  v.VEND_ID, VEND_NAME, BRAND_NAME, 
count(p.PROD_SKU) as NUMPRODUCTS
from LGBRAND b join LGPRODUCT p 
on b.BRAND_ID = p.BRAND_ID
join LGSUPPLIES s 
on p.PROD_SKU = s.PROD_SKU
join LGVENDOR v on s.VEND_ID = v.VEND_ID
group by v.VEND_ID, VEND_NAME, BRAND_NAME
ORDER BY 2,3;


#Write a query to display the employee number, last name, first name, and sum of invoice totals for all employees who completed an invoice. 
#Sort the output by employee last name and then by first name (Partial results shown in Figure P7.44).
select EMP_NUM,EMP_LNAME,EMP_FNAME,sum(INV_TOTAL) 
as TOTALINVOICES
from LGINVOICE i join LGEMPLOYEE e 
on e.EMP_NUM=i.EMPLOYEE_ID
group by 1,2,3
order by 2,3;


#Write a query to display the largest average product price of any brand (Figure P7.45).
select max(price) as 'LARGEST AVERAGE'
from(select BRAND_ID, round(avg(PROD_PRICE),2) as price
from LGPRODUCT
group by BRAND_ID)a;

#Write a query to display the brand ID, brand name, brand type, 
#and average price of products for the brand that has the largest average product price (Figure P7.46).
select p.BRAND_ID,BRAND_NAME,BRAND_TYPE,
round(avg(p.PROD_PRICE),2)
as AVGPRICE
from LGPRODUCT p join LGBRAND b on b.BRAND_ID=p.BRAND_ID
group by 1,2,3
having round(avg(p.PROD_PRICE),2)=
(select max(price) as 'LARGEST AVERAGE'
from(select BRAND_ID, round(avg(PROD_PRICE),2) as price
from LGPRODUCT
group by BRAND_ID)a);


#Write a query to display the manager name, department name, department phone number, employee name, customer name, invoice date, 
#and invoice total for the department manager of the employee who made a sale to a customer whose last name is Hagan on May 18, 2021 (Figure P7.47).
select c1.EMP_FNAME,c1.EMP_LNAME,DEPT_NAME,DEPT_PHONE,
e.EMP_FNAME,e.EMP_LNAME,CUST_FNAME,CUST_LNAME,INV_DATE,
INV_TOTAL
from LGCUSTOMER c join LGINVOICE i
on c.CUST_CODE=i.CUST_CODE
join LGEMPLOYEE e 
on i.EMPLOYEE_ID=e.EMP_NUM
join LGDEPARTMENT d 
on d.DEPT_NUM=e.DEPT_NUM
join LGEMPLOYEE c1
on c1.EMP_NUM=d.EMP_NUM
where i.INV_DATE='2021-5-18' and CUST_LNAME='HAGAN';



#Write a query to display the current salary for each employee in department 300. Assume that only current employees are kept in the system,
#and therefore the most current salary for each employee is the entry in the salary history with a NULL end date. 
#Sort the output in descending order by salary amount (Figure P7.48).
select e.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
from LGEMPLOYEE e join LGSALARY_HISTORY h
on e.EMP_NUM=h.EMP_NUM
where SAL_END is NULL and DEPT_NUM=300
order by 4 desc;


#Write a query to display the starting salary for each employee. The starting salary would be the entry in the salary history 
#with the oldest salary start date for each employee. Sort the output by employee number (Figure P7.49).
select e.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
from LGEMPLOYEE e join LGSALARY_HISTORY h
on e.EMP_NUM=h.EMP_NUM
where SAL_FROM=(select min(SAL_FROM)
			 from	LGSALARY_HISTORY 
       where EMP_NUM=e.EMP_NUM)
order by 1;

#Write a query to display the invoice number, line numbers, product SKUs, product descriptions, 
#and brand ID for sales of sealer and top coat products of the same brand on the same invoice. 
#Sort the results by invoice number in ascending order, first line number in ascending order, 
#and then by second line number in descending order (Figure P7.50).
select a1.INV_NUM,a1.LINE_NUM,b1.PROD_SKU,
b1.PROD_DESCRIPT,
a2.LINE_NUM,b2.PROD_SKU,b2.PROD_DESCRIPT,b1.BRAND_ID
from (LGLINE a1 join LGPRODUCT b1 
on a1.PROD_SKU = b1.PROD_SKU)
join 
(LGLINE a2 join LGPRODUCT b2
on b2.PROD_SKU = a2.PROD_SKU)
on a1.INV_NUM = a2.INV_NUM
where b1.PROD_CATEGORY = 'Sealer' and b2.PROD_CATEGORY = 'Top Coat' and b1.BRAND_ID = b2.BRAND_ID
order by 1,2, a2.LINE_NUM desc;


#The Binder Prime Company wants to recognize the employee who sold the most of its products during a specified period.
#Write a query to display the employee number, employee first name, employee last name, email address, 
#and total units sold for the employee who sold the most Binder Prime brand products between November 1, 2021, 
#and December 5, 2021. If there is a tie for most units sold, sort the output by employee last name (Figure P7.51).
select	e.EMP_NUM,EMP_FNAME,EMP_LNAME,EMP_EMAIL,TOTAL
from	LGEMPLOYEE e join 
(select EMPLOYEE_ID, sum(LINE_QTY) as total
from LGINVOICE i
join LGLINE l
on l.INV_NUM=i.INV_NUM
join LGPRODUCT p
on p.PROD_SKU=	l.PROD_SKU
join LGBRAND b
on	b.BRAND_ID=	p.BRAND_ID 
where	b.BRAND_NAME=	'BINDER PRIME'	
and	INV_DATE between	'2021-11-01'	and	'2021-12-05'
group	by 1)a
on e.EMP_NUM=EMPLOYEE_ID
where TOTAL=(select max(TOTAL)
from (select EMPLOYEE_ID,
sum(LINE_QTY) as total
from LGINVOICE i
join LGLINE l
on l.INV_NUM=i.INV_NUM
join LGPRODUCT p
on p.PROD_SKU=	l.PROD_SKU
join LGBRAND b
on	b.BRAND_ID=	p.BRAND_ID 
where	b.BRAND_NAME=	'BINDER PRIME'	
and	INV_DATE between	'2021-11-01'	and	'2021-12-05'
group by EMPLOYEE_ID)b)
order by 3;


#Write a query to display the customer code, first name, and last name of all customers who have had at least one invoice completed 
#by employee 83649 and at least one invoice completed by employee 83677. Sort the output by customer last name 
#and then first name (Partial results are shown in Figure P7.52).
select	c.CUST_CODE,	c.CUST_FNAME,	c.CUST_LNAME
from 	LGCUSTOMER	c join	LGINVOICE	i on c.CUST_CODE=i.CUST_CODE
where	EMPLOYEE_ID=83649 and c.CUST_CODE in(select	CUST_CODE	 
from	LGINVOICE
where	EMPLOYEE_ID=83677)
order	by CUST_LNAME, CUST_FNAME;

#LargeCo is planning a new promotion in Alabama (AL) and wants to know about the largest purchases made by customers in that state. 
#Write a query to display the customer code, customer first name, last name, full address, invoice date, 
#and invoice total of the largest purchase made by each customer in Alabama. Be certain to include any customers in Alabama 
#who have never made a purchase; their invoice dates should be NULL and the invoice totals should display as 0.
#Sort the results by customer last name and then first name (Partial result are shown in Figure P7.53).
select c.CUST_CODE, c.CUST_FNAME, c.CUST_LNAME, c.CUST_STREET, c.CUST_CITY, c.CUST_STATE, c.CUST_ZIP,
i.INV_DATE, i.INV_TOTAL as 'Largest Invoice'
from LGCUSTOMER c join LGINVOICE i on i.CUST_CODE = c.CUST_CODE
where c.CUST_STATE = 'AL'
and i.INV_TOTAL = (select max(INV_TOTAL) 
from LGINVOICE a 
where a.CUST_CODE = c.CUST_CODE)
union
select CUST_CODE, CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE,CUST_ZIP, NULL, 0
from LGCUSTOMER
where CUST_STATE = 'AL'
and CUST_CODE not in (select CUST_CODE from LGINVOICE)
order by CUST_LNAME, CUST_FNAME;


#One of the purchasing managers is interested in the impact of product prices on the sale of products of each brand. 
#Write a query to display the brand name, brand type, average price of products of each brand, and total units sold of products of each brand. 
#Even if a product has been sold more than once, its price should only be included once in the calculation of the average price.
#However, you must be careful because multiple products of the same brand can have the same price, and each of those products must be included in the calculation of the brand’s average price. 
#Sort the result by brand name (Figure P7.54).
select	BRAND_NAME,	BRAND_TYPE,	round(avgprice,2)	as	"Average Price",	unitSold	as	"Units Sold"
from	LGBRAND	b 
join(select BRAND_ID,avg(PROD_PRICE) as avgprice 
from LGPRODUCT
group by BRAND_ID)a
on b.BRAND_ID=a.BRAND_ID
join(select BRAND_ID,sum(LINE_QTY)as unitSold
from LGPRODUCT p join LGLINE l on p.PROD_SKU=l.PROD_SKU
group by BRAND_ID)c on c.BRAND_ID=b.BRAND_ID
order	by BRAND_NAME;


#The purchasing manager is still concerned about the impact of price on sales. 
#Write a query to display the brand name, brand type, product SKU, product description, and price of any products that are not a premium brand, 
#but that cost more than the most expensive premium brand products (Figure P7.55).
select BRAND_NAME,BRAND_TYPE,PROD_SKU,PROD_DESCRIPT,PROD_PRICE
from LGPRODUCT p join LGBRAND b on p.BRAND_ID=b.BRAND_ID
where BRAND_TYPE != "PREMIUM" and PROD_PRICE>
(select max(PROD_PRICE)
from LGPRODUCT a join LGBRAND c on a.BRAND_ID=c.BRAND_ID
where BRAND_TYPE = "PREMIUM");
