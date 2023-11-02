Select * From superstore;
Alter Table superstore modify column OrderDate date;
Alter Table superstore modify column ShipDate date;

/* Total sales and Total profit */
Select sum(Sales) as Total_Sales, sum(Profit) as Total_Profit
from superstore;

/* Total sales and profit by categoty*/
Select Category, sum(Sales) as Total_sales, sum(Profit) as Total_Profit
from superstore
group by Category;

/* Total sales and profit by sub category*/
Select SubCategory, Quantity, sum(Sales) as Total_sales, sum(Profit) as Total_Profit
from superstore
group by SubCategory
Order by Total_Profit;

Select count(distinct(ProductID)) from superstore;
Select count(distinct(ProductName)) from superstore;
Select count(distinct(CustomerID)) from superstore;
Select count(distinct(CustomerName)) from superstore;

/* Total Order, Sales and Profit by Each Subcategory*/
Select Category, SubCategory, Count(CustomerName) as num_of_orders , sum(Sales) as Total_sales, sum(Profit) as Total_Profit
from superstore
group by SubCategory
order by Total_profit;

/* Total sales and Total Proft by segment*/
Select Segment, sum(Sales) as Total_sales, sum(Profit) as Total_Profit
from superstore
group by Segment;

/* Total sales and Total Profit by region*/
Select Region, sum(Sales) as Total_sales, sum(Profit) as Total_Profit
from superstore
group by Region;

/* Total sales and Profit over years*/
Select year(Orderdate), sum(Profit) as Total_Profit
from superstore
group by year(Orderdate);