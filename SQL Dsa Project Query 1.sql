  
-Create the database KULTRA_MEGA_STORES_INVENTORY
---IMPORT THE KMS SQL CASE STUDY CSV FILE
select * from KMS_File
---Alter the following columns:Sales, Discount, Profit, Unit_Price Shipping_Cost, Product_Base_Margin  to 2 decimal places
alter table KMS_File
alter column Sales decimal (10,2)
alter table KMS_File
alter column Discount decimal (10,2)
alter table KMS_File
alter column Profit decimal (10,2)
alter table KMS_File
alter column Unit_Price decimal (10,2)
alter table KMS_File
alter column Shipping_Cost decimal (10,2)
alter table KMS_File
alter column Product_Base_Margin decimal (10,2)

---CASE SCENERIO 1

----1. Which Product category had the highest sales?
select top 1 Product_Category, sum(Sales) as highest_Sales from KMS_File
Group by Product_Category
ORDER BY highest_Sales desc

----2. what are the top 3 and bottom 3 regions in terms of sales?
---Top 3 Regions
select top 3 Region, sum(Sales) as Profitable_Region from KMS_File
Group by Region
ORDER BY Profitable_Region desc

---Bottom 3 Regions
select top 3 Region, sum(Sales) as Profitable_Region from KMS_File
Group by Region
ORDER BY Profitable_Region Asc

select * from KMS_File
---3. what were the total sales of appliances in ontario?
select sum(sales) as Total_sales from KMS_File
where Province = 'Ontario'
and Product_Sub_Category = 'Appliances'

----4. Advice the management of kms on what to do to increase the revenue from the bottom 10 customers?

---STEP 1:Identify the bottom 10 customers using the query below
select  Top 10 Customer_Name, sum(Unit_Price*Order_Quantity*(1-Discount)) as Total_Revenue from KMS_File
Group by Customer_Name
ORDER BY Total_Revenue asc

---STEP 2: Apply the following strategies to the bottom 10 customers identified :
----A. Offer exclusive discounts for each product bought just for this group of customers
----B. Improve Customer Engagement using various mode of communication(email, Sms, Phone follow-ups)
----C. Analyze product bought and suggest higher value product or complementary items
----D. create product bundles that add value while increasing their total spend.e.g buy 2 get 1 free on items purchased previously
----e. Run a win-back campaign with time-limited offers 

----5. Which shipping method did KMS incurred the most shipping cost
Select Top 1 Ship_Mode, Sum(Shipping_Cost) as Total_Ship_MCost from KMS_File
Group by Ship_Mode
order by Total_Ship_MCost asc

---CASE SCENERIO 2
select * from KMS_File

--6. Who are the most valuable Customers, and what products or services do they typically purchase?
Select Top 1 Customer_Segment, Product_Sub_Category, Sum(Unit_Price*Order_Quantity*(1-Discount)) as Total_Revenue from KMS_File
Group by Customer_Segment, Product_Sub_Category
order by Total_Revenue desc

---7. Which small business customer had the highest sales?
select top 1 Customer_Name, sum(sales) as highest_Sales from KMS_File
where Customer_Segment = 'Small Business'
Group by Customer_Name
ORDER BY  highest_Sales desc

---8. Which corporate Customer placed the most number of orders in 2009-2012?
select Top 1 Customer_Name, count(Order_ID) as Total_Orders from KMS_File
where Customer_Segment = 'Corporate'
Group by Customer_Name
order by Total_Orders desc 

---9. Which Consumer Customer was the most profitable one?
select top 1 Customer_Name, sum(sales) as Most_Profitable_Customer from KMS_File
where Customer_Segment = 'Consumer'
Group by Customer_Name
order by Most_Profitable_Customer desc

---10. Which customer returned items, and what segment do they belong to ?
select Customer_Name, Customer_Segment, Profit from KMS_File
where Profit< 0 or Sales < = 0
--Negative profit is an indicator of returned item(Because companies lose money on returns)

select * from KMS_File
---11. Do you think the company appropriately spent shipping costs based on the order priority?

select Ship_Mode, Order_Priority, AVG(Shipping_Cost) as Avg_Ship_Cost, Sum(Shipping_Cost) as Total_Shipping_Cost from KMS_File
Where Order_Priority = 'Low' or Ship_Mode = 'Delivery Truck' and Ship_Mode='Express Air'
Group by Ship_Mode, Order_Priority
order by Order_Priority,Total_Shipping_Cost desc
--- Yes based on this result, the company maximised the used of delivery truck over Express Air as a shipping mode when the 
--customer's need for the product isn't urgent.