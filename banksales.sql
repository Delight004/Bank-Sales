CREATE TABLE Bank_sales(
	customerid INT,
	age INT,
	income DECIMAL(15,2),
	product VARCHAR,
	amount DECIMAL(15,2),
	region VARCHAR
);

CREATE TABLE customer(
	customerid INT PRIMARY KEY,
	age INT,
	income DECIMAL(15,2)
);

INSERT INTO customer
SELECT DISTINCT customerid, age, income
FROM Bank_sales;

CREATE TABLE product(
	productid INT, 
	product VARCHAR,
	amount DECIMAL(15,2)
);

INSERT INTO product
SELECT DISTINCT customerid AS productid, product, amount
FROM Bank_sales
ORDER BY productid DESC;


CREATE TABLE location(
	locationid INT,
	region VARCHAR
);

INSERT INTO location
SELECT DISTINCT customerid AS locationid, region
FROM Bank_sales; 

--1Retrieve all distinct regions from the dataset.

SELECT DISTINCT(region)
FROM location;

--2.Count the total number of customers in each region.

SELECT COUNT(locationid) AS No_of_customers, region
FROM location
GROUP BY region; 


--3.Find the total amount spent by customers in the 'North' region.

SELECT SUM(amount) AS tota_north, region, COUNT(region) AS count
FROM bank_sales
WHERE region = 'North'
GROUP BY region;


--4.List all customers who are older than 50 years

SELECT customerid, age
FROM bank_sales
WHERE age > 50
GROUP BY customerid, age
ORDER BY age ASC;

--5. Find the average income of customers who purchased product 'A'.

SELECT AVG(income) AS Average_income, product
FROM bank_sales
WHERE product = 'A'
GROUP BY product;

--6. Which region has the highest total sales amount?

SELECT sum(amount) AS total_sales, region
FROM bank_sales
GROUP BY region
ORDER BY total_sales DESC;


--7. Count the number of customers who have an income greater than $100,000.

SELECT count(income)
FROM bank_sales
WHERE income > 100000;

--8. List the customer IDs of those who purchased more than one product type.

SELECT customerID
FROM bank_sales
GROUP BY customerID
HAVING COUNT(DISTINCT product) > 1;


--9. Find the maximum sales amount for each product.

SELECT sum(amount) AS total_amount, product
FROM bank_sales
GROUP BY product
ORDER BY total_amount;

--10. Retrieve the total sales amount for customers aged between 30 and 40.

SELECT  sum(amount) AS amount_btw_30_40
FROM bank_sales
WHERE age BETWEEN 30 and 40;

--11 Which product has the highest total sales amount?
SELECT product, sum(amount) AS highest_amount
FROM bank_sales
GROUP BY product
ORDER BY highest_amount DESC
LIMIT 1;


--12. Find the average age of customers for each product category.

SELECT AVG(age) as age_avarage, product
FROM bank_sales
GROUP BY product
ORDER BY age_avarage DESC;

--13. List all customers from the 'East' region who purchased product 'D'.

SELECT customerid, region, product
FROM bank_sales
WHERE region = 'East' AND
	  product = 'D';


--14. Count how many customers have an income below $50,000.
SELECT count(customerid)
FROM bank_sales
WHERE income < 50000;

--15. Find the total sales amount by each age group (20-30, 31-40, etc.)
SELECT 
  CASE 
    WHEN Age BETWEEN 20 AND 30 THEN '20-30'
    WHEN Age BETWEEN 31 AND 40 THEN '31-40'
    WHEN Age BETWEEN 41 AND 50 THEN '41-50'
    WHEN Age BETWEEN 51 AND 60 THEN '51-60'
    WHEN Age BETWEEN 61 AND 70 THEN '61-70'
    ELSE '71+'
  END AS age_group,
  SUM(amount) AS total_sales
FROM bank_sales
GROUP BY age_group;









