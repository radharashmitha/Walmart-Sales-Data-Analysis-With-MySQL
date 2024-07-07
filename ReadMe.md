#**Walmart Sales Data Analysis with SQL**
##**About**

The Walmart Sales Data Analysis project is designed to delve into Walmart’s sales data to identify high-performing branches and products, analyze sales trends, and understand customer behavior. The goal is to enhance and refine sales strategies. Data for this study comes from the Kaggle Walmart Sales Forecasting Competition, which includes historical sales data from 45 Walmart stores across various regions. Participants are tasked with forecasting sales for each department within these stores, taking into account the impact of holiday markdown events on sales.

##**Project Objectives**

The primary objectives of this project are as follows:

1.	Understand the factors influencing sales across different Walmart branches.
2.	Analyze product performance and identify areas for improvement.
3.	Explore sales trends to evaluate the effectiveness of sales strategies.
4.	Segment customers based on purchasing behavior and profitability.
   
##**Dataset Description**
-	The dataset contains sales transactions from three Walmart branches located in Mandalay, Yangon, and Naypyitaw.
-It consists of 17 columns and 1000 rows, including information such as invoice IDs, branch details, customer types, product lines, prices, quantities, VAT, dates, times, payment methods, COGS, gross margin percentages, gross incomes, and ratings.

##**Column Details**
|Column Name|Description|Data Type|
|invoice_id|Invoice of the sales made|VARCHAR(30)|
|branch|Branch at which sales were made|VARCHAR(5)|
|city|Location of the branch|VARCHAR(30)|
|customer_type|Type of the customer|VARCHAR(30)|
|gender|Gender of the customer making the purchase|VARCHAR(10)|
|product_line|Product line of the product sold|VARCHAR(100)|
|unit_price|Price of each product|DECIMAL(10, 2)|
|quantity|Amount of the product sold|INT|
|VAT|Amount of tax on the purchase|FLOAT(6, 4)|
|total|Total cost of the purchase|DECIMAL(12, 4)|
|date|Date on which the purchase was made|DATE|
|time|Time at which the purchase was made|TIMESTAMP|
|payment_method|Total amount paid|DECIMAL(10, 2)|
|cogs|Cost Of Goods Sold|DECIMAL(10, 2)|
|gross_margin_pct|Gross margin percentage|FLOAT(11, 9)|
|gross_income|Gross Income|DECIMAL(12, 4)|
|rating|Customer rating|FLOAT(2, 1)|

##**Approach Used**
1.	Data Wrangling: 
- Inspect data for NULL values and replace missing data.
2.	Database Construction: 
-	Create tables and insert data.
- Set NOT NULL constraints to filter out null values.
3.	Feature Engineering: 
-	Add new columns: 
   - time_of_day: Insight into sales during morning, afternoon, and evening.
	 - day_name: Extracted days of the week (Mon, Tue, Wed, Thur, Fri) to analyze weekly patterns.
   -  month_name: Extracted months (Jan, Feb, Mar) to determine peak sales months.
4.	Exploratory Data Analysis (EDA): 
-	Answer project-specific questions using data insights.
  
**##Usage**
1.	Install any necessary dependencies.
2.	Set up the database and create tables.
3.	Execute queries for analysis (e.g., product analysis, sales trends, customer segmentation).
