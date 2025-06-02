use project;

desc superstore;

-- 🔹 Sales & Profit Analysis
-- 1)What is the total sales and profit for each region?

select region,sum(Profit) as TotalProfit,sum(Sales) as TotalSales from superstore group by region;

-- 2)Which products have generated the highest profit?
select `product name`,sum(profit) as HighestProfit from superstore group by `product name` order by HighestProfit desc limit 1;

-- 3)What is the monthly trend of sales over the years?
select date_format(str_to_date(`order date`,'%m%d%Y'),'%Y-%m') as month_year,
sum(sales) as TotalSales
from superstore group by month_year
order by month_year;

-- 4)What is the total discount given in each state?
select state,sum(discount) as TotalDiscount from superstore group by state order by TotalDiscount desc;

-- 5)Which product categories are least profitable?
select category,sum(profit) as LeastProfitable from superstore group by category order by LeastProfitable asc;


-- 🔹 Customer & Segment Analysis
-- 6)Which segment has the highest total sales?
select segment,sum(sales) as TotalSales from superstore group by segment order by totalsales desc;

-- 7)How many unique customers are there in each region?
select region,count(distinct `customer name`) as UniqueCustomer from superstore group by region;

-- 8)Who are the top 10 customers by sales?
select `customer name`,sum(sales) as TotalSales,rank() over (order by sum(sales) desc) as Top10CustomerName from superstore group by `customer name` limit 10;

-- 9)What is the average profit per customer?
SELECT 
    ROUND(SUM(Profit) / COUNT(DISTINCT `Customer Name`), 2) AS AvgProfitPerCustomer
FROM 
    superstore;

-- 10)Which segment receives the highest average discount?
SELECT 
    Segment, 
    AVG(Discount) AS AvgDiscount, 
    RANK() OVER (ORDER BY AVG(Discount) DESC) AS HighestAverageDiscount
FROM 
    superstore
GROUP BY 
    Segment;
    
-- 🔹 Product & Category Analysis
-- 11)What are the top 5 best-selling products by quantity?
select `product name`,count(quantity) as BestSellingProduct,RANK() OVER(order by count(quantity) desc) as TopFiveProduct from superstore group by `product name` limit 5;

-- 12)What is the average sales and profit per category and sub-category?
select category,`sub-category`,avg(sales) as AvgSales,avg(profit) as AvgProfit from superstore group by category,`sub-category`;

-- 13)Are there any products sold at a loss (negative profit)?
select `product name`,sum(profit) as NagativeProfit from superstore group by `product name` having NagativeProfit < 0 order by NagativeProfit desc;

-- 14) which products have a nagative profit
select count(*) as nagativeproduct
from(select `product name`,sum(profit) as TotalProfit from superstore 
group by `product name` having sum(profit) < 0) as TotalNagativeProducts;

-- 15)Which sub-category has the highest return on sales (profit/sales ratio)?
select `sub-category`,avg(sales) as AvgSales from superstore group by `sub-category`;

-- 16)Which products have been sold most frequently?
select `product name`,count(quantity) as TotalSoldProduct from superstore group by `product name` order by TotalSoldProduct desc;\

-- 🔹 Geographic Analysis
-- 17)What is the total sales and profit by city and state
select city,state,sum(sales) as totalsales,sum(profit) as totalprofit from superstore group by state,city;

-- 18)Which state has the highest average discount?
select state,avg(discount) as HighestDiscount from superstore group by state order by HighestDiscount desc;

-- 19)Which postal code has the highest number of orders?
SELECT `Postal Code`, COUNT(*) AS OrderCount
FROM superstore
GROUP BY `Postal Code`
ORDER BY OrderCount DESC
LIMIT 1;

-- 20)Which regions have the lowest quantity sold?
select region,sum(quantity) as lowestquantity from superstore group by region order by lowestquantity asc;

-- 🔹 Shipping & Time Analysis
-- 21)What is the average shipping delay (difference between ship date and order date)?
SELECT 
    AVG(DATEDIFF(STR_TO_DATE(`Ship Date`, '%m/%d/%Y'), STR_TO_DATE(`Order Date`, '%m/%d/%Y'))) AS AvgShippingDelay
FROM 
    superstore
WHERE 
    `Order Date` IS NOT NULL AND `Ship Date` IS NOT NULL;

-- 22)Which shipping mode is used most frequently?
SELECT `Ship Mode`, COUNT(`Order ID`) AS UsageCount
FROM superstore
GROUP BY `Ship Mode`
ORDER BY UsageCount DESC;

-- 23)Which shipping mode results in the highest average profit?
select `ship mode`,avg(profit) as HighestAvgProfit from superstore group by `ship mode` order by HighestAvgProfit desc;

-- 24)How many orders were shipped late?
SELECT COUNT(*) AS LateOrders
FROM superstore
WHERE 
    STR_TO_DATE(`Ship Date`, '%m/%d/%Y') > STR_TO_DATE(`Order Date`, '%m/%d/%Y');

-- 25)Are there seasonal trends in sales (e.g., month-wise sales analysis)?
SELECT 
    DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS MonthYear,
    SUM(Sales) AS TotalSales
FROM 
    superstore
GROUP BY 
    MonthYear
ORDER BY 
    MonthYear;

-- 🔹 Discount & Quantity Analysis
-- 26)What is the relationship between discount and profit?
select discount,avg(profit) as Avg_Profit from superstore group by discount;

-- 27)Are higher discounts leading to higher sales?
select discount,max(sales) as maxsales from superstore group by discount order by discount;

-- 28)Which products are sold most often with a discount?
SELECT `Product Name`, SUM(Quantity) AS TotalQuantityWithDiscount
FROM superstore
WHERE Discount > 0
GROUP BY `Product Name`
ORDER BY TotalQuantityWithDiscount DESC
LIMIT 10;

-- 29)What is the average quantity per order by segment?
select segment,avg(quantity) as AvgQuantitySegmentWise from superstore group by segment;

-- 30)Do high-quantity orders result in more profit?
select quantity,sum(profit) as MoreProfit from superstore group by quantity order by quantity desc;