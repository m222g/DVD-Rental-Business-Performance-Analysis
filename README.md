# DVD Rental Business Performance Analysis

## Executive Summary
This project explores a DVD rental business and its performance over time. Using SQL, I uncovered insights across store locations, customer spending, film popularity, and revenue trends. The goal was to mimic a real-world analytics workflow by structuring the data and building a KPI reporting layer. The analysis turns raw data into a structured data model using SQL views, allowing scalable reporting to help aid decision-making.

### Business Problem
The DVD rental company doesn’t have easy access to store-level and company-level performance insights. This project utilizes the rental data to answer the following questions:
1.	Which stores generate the most revenue and rentals?
2.	Which customers contribute most to profit?
3.	Can customers be segmented by value?
4.	Which films are most profitable in terms of revenue (not just most rented)?
5.	How does revenue trend over time?
6.	Is revenue evenly distributed or concentrated among certain customers and/or stores?
These insights will enable efficient resource allocation and effective decision-making.

<img width="468" height="193" alt="Overview of dataset tables and relationships among them" src="https://github.com/user-attachments/assets/688317db-16d6-49d5-bde9-8e170613171f" />
Overview of dataset tables and relationships among them. 

### Methodology
Data Extraction: Pulled rental data from the database

Data Preparation: Joined rental, inventory, payment, store, and film tables to create a unified dataset

Data Modeling: Utilized views to simplify analysis and allow reusability

`store_rentals` - links rentals to store and inventory tables

`payment_info` - enhances payment info using added context from the film and store tables

`customer_spending` - aggregates customers’ lifetime spending contribution

`film_performance` - calculates rental count and revenue for each film

### Skills
-	SQL (JOINs, Aggregations, CTEs, Views, Window Functions)
-	Data Modeling (Views-based structure)
-	KPI Design (Revenue, retention, segmentation)
-	Data Management: Relational modeling, ETL

### Results and Insights

#### Store Performance table
<img width="468" height="62" alt="Store performance table" src="https://github.com/user-attachments/assets/3a3a05fc-f95a-4e40-859f-0963876ed945" />
The business has 2 active stores, each accounting for about 50% of total revenue. Store outperformed Store 1 slightly by:
-	~$11,510 higher revenue
-	Slightly higher revenue per rental (+$0.46) 
**Insights**: Store performance is evenly distributed. This suggests the business is **not overly dependent** on a single location.


#### Customer segmentation by revenue

<img width="468" height="66" alt="Customer segmentation by revenue" src="https://github.com/user-attachments/assets/7dbb1afa-51e8-42a8-bd48-f801f6d4fcf4" />

Most customers spent $1000s, so I segmented their loyalty as:
1.	High Value: > $4000
2.	Mid Value: $2500 - $4000
3.	Low Value: < $2500
**Insights**: Most customers fall into mid- to high-value segments, with only 2 low-value segments. This suggests a strong, loyal customer base that, overall, exhibits high spending behavior. 

#### Revenue concentration

<img width="249" height="50" alt="revenue concentration" src="https://github.com/user-attachments/assets/87de1bbd-8d4a-418d-8758-ac5592ee20d3" />

The top 10 highest-spending customers account for only ~2.38% of total revenue. 

**Insights**: Revenue is not concentrated among a small group of customers; it is distributed well across the entire customer base. 

#### Film Performance

<img width="468" height="218" alt="Top 10 films by revenue" src="https://github.com/user-attachments/assets/ec1ad6a8-5846-4267-946b-ad75bc4c06eb" />

**Insights**: The top 10 films that generate the most revenue are priced at $63-$68 per rental. This suggests that pricing is likely standardized and that differences in revenue are driven more by rental volume.  


## Business Recommendations
**1.	Maintain balanced store operations**
Since both perform similarly in terms of revenue and rental volume:
-	Continue current allocation of resources
-	Monitor trends over time to detect early shifts
-	Investigate performance differences

**2.	Focus on customer retention, not acquisition**
Revenue is evenly distributed across all customers, with no reliance on the top spenders. Maintaining current customers’ loyalty is a top priority. 
-	Invest in loyalty programs and retention strategies
-	Track customer behavior over time to identify churn risk

**3.	Optimize inventory**
Revenue is primarily driven by rental volume, so revenue prices should not be altered. 
-	Prioritize stocking films that are in high demand to avoid missing out on revenue opportunities
-	Ensure availability during peak periods for films with high rental counts
-	Promote films with higher revenue per rental that are lower in demand to increase their visibility

**4.	Introduce targeted segmentation strategies**
Most customers fall into mid- to high-value segments, indicating strong overall spending behavior. Different strategies should be developed for each segment.
-	High-value: reward their loyalty and encourage continued engagement
-	Mid-value: upsell through bundles or recommendations
-	Low-value: increase engagement through promotions and discounts

**5.	 Leverage revenue trends for planning/forecasting**
Monthly revenue trends show consistent growth with periodic fluctuations.
-	Align inventory and promotions with peak demand periods
-	Use historical trends to predict future performance
-	Plan marketing campaigns around high-demand seasons

### Next Steps
1.	Expand geographical/store-level analysis to identify regional demands
2.	Analyze customer retention and repeat behavior
3.	Incorporate cost margins if cost data becomes available
4.	Automate reporting using scheduled queries

