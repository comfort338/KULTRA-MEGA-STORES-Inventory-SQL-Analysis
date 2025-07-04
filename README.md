# KULTRA-MEGA-STORES-Inventory-SQL-Analysis
This project performs detailed data analysis using SQL on the inventory and sales data of KULTRA MEGA STORES (KMS). The goal is to help stakeholders gain actionable insights from the store's performance dataset.


📄 Project Overview

The SQL queries answer critical business questions such as:

    Top-performing product categories and regions
    Customer behavior and segmentation
    Shipping cost efficiency
    Recommendations for increasing revenue

The analysis is divided into two main case scenarios to guide business decisions using data-driven insights.
🧠 Tools Used

    Microsoft SQL Server / PostgreSQL

    SQL (T-SQL syntax)

    GitHub for version control

📁 Files

    SQL Dsa Project Query.sql: Main SQL query file

    KMS_File.csv (assumed): Raw dataset

    README.md: Project documentation

📦 Dataset

Table Name: KMS_File
Additional Table: Order_Status (for return status)
Imported from a CSV file into a relational database.
⚙️ Preprocessing Steps

Before analysis, the following columns were formatted to two decimal places:

    Sales, Discount, Profit, Unit_Price, Shipping_Cost, Product_Base_Margin

ALTER TABLE KMS_File
ALTER COLUMN Sales DECIMAL(10,2);
-- Repeated for other relevant columns

📊 Case Scenario 1: Sales & Revenue Optimization

1️⃣ Which product category had the highest sales?

SELECT TOP 1 Product_Category, SUM(Sales) AS Highest_Sales
FROM KMS_File
GROUP BY Product_Category
ORDER BY Highest_Sales DESC;

2️⃣ What are the top 3 and bottom 3 regions in terms of sales?

    Top 3 Regions

SELECT TOP 3 Region, SUM(Sales) AS Profitable_Region
FROM KMS_File
GROUP BY Region
ORDER BY Profitable_Region DESC;

    Bottom 3 Regions

SELECT TOP 3 Region, SUM(Sales) AS Profitable_Region
FROM KMS_File
GROUP BY Region
ORDER BY Profitable_Region ASC;

3️⃣ Total sales of appliances in Ontario?

SELECT SUM(Sales) AS Total_Sales
FROM KMS_File
WHERE Province = 'Ontario' AND Product_Sub_Category = 'Appliances';

4️⃣ How to increase revenue from bottom 10 customers?

SELECT TOP 10 Customer_Name, SUM(Unit_Price * Order_Quantity * (1 - Discount)) AS Total_Revenue
FROM KMS_File
GROUP BY Customer_Name
ORDER BY Total_Revenue ASC;

📌 Recommended Strategies:

    Personalized discounts

    Customer engagement via email/SMS/phone

    Product up-selling and bundling

    Win-back campaigns

5️⃣ Which shipping method incurred the highest shipping cost?

SELECT TOP 1 Ship_Mode, SUM(Shipping_Cost) AS Total_Ship_MCost
FROM KMS_File
GROUP BY Ship_Mode
ORDER BY Total_Ship_MCost DESC;

📊 Case Scenario 2: Customer & Operational Insights

6️⃣ Most valuable customers and their purchases?

SELECT TOP 1 Customer_Segment, Product_Sub_Category,
       SUM(Unit_Price * Order_Quantity * (1 - Discount)) AS Total_Revenue
FROM KMS_File
GROUP BY Customer_Segment, Product_Sub_Category
ORDER BY Total_Revenue DESC;

7️⃣ Highest sales among small business customers?

SELECT TOP 1 Customer_Name, SUM(Sales) AS Highest_Sales
FROM KMS_File
WHERE Customer_Segment = 'Small Business'
GROUP BY Customer_Name
ORDER BY Highest_Sales DESC;

8️⃣ Corporate customer with most orders (2009–2012)?

SELECT TOP 1 Customer_Name, COUNT(Order_ID) AS Total_Orders
FROM KMS_File
WHERE Customer_Segment = 'Corporate'
GROUP BY Customer_Name
ORDER BY Total_Orders DESC;

9️⃣ Most profitable consumer customer?

SELECT TOP 1 Customer_Name, SUM(Sales) AS Most_Profitable_Customer
FROM KMS_File
WHERE Customer_Segment = 'Consumer'
GROUP BY Customer_Name
ORDER BY Most_Profitable_Customer DESC;

🔟 Which customers returned items?

SELECT K.Customer_Name, K.Order_ID, K.Customer_Segment
FROM KMS_File K
JOIN Order_Status O ON K.Order_ID = O.Order_ID
WHERE O.Status = 'Returned';

🚚 Shipping Cost vs Order Priority Does shipping cost align with order priority?

SELECT Order_Priority, Ship_Mode,
       COUNT(Order_ID) AS Order_Count,
       AVG(Shipping_Cost) AS Avg_Shipping_Cost
FROM KMS_File
GROUP BY Order_Priority, Ship_Mode
ORDER BY Order_Priority, Avg_Shipping_Cost DESC;

📌 Insight: Shipping resources were not efficiently allocated based on urgency. Some low-priority orders incurred higher shipping costs than high-priority ones

✅ Conclusion This project offers insights for:

    Targeted customer engagement

    Region-wise and category-wise marketing

    Shipping and logistics optimization

    High-value customer retention

📫 Contact
For questions or collaborations, reach out via Email[commyjohn700@gmail.com]
