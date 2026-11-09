# retail-sales-customer-insights

# Summary

Analysis of 541,909 online retail transactions using MySQL and Microsoft Excel. The project covers data cleaning, sales trends, product and country performance, and RFM customer segmentation, with findings presented in an Excel dashboard.

# Business Questions Answered
How much gross revenue did the business generate, and how did it change month to month?

Which products drive the most sales?

Which countries contribute the most revenue?

Which customers are the most valuable, and which need re-engagement?


# Key Findings
Total gross sales were approximately £10.67 million under the project's transaction filters.

November 2011 was the strongest month, with approximately £1.51 million in gross sales.

Regency Cakestand 3 Tier was the top product by gross sales at £174,484.74.

The exploratory RFM analysis classified 905 customers as high-value active and 1,734 customers as needing re-engagement.

# Tools Used & Tool	Purpose
MySQL 8.0	Data cleaning, aggregation, filtering, joins, customer analysis

SQL	Sales metrics, product rankings, RFM segmentation

Microsoft Excel	Data formatting, charts, KPI dashboard

# Analysis Performed
**Data cleaning**: Investigated missing customer IDs, cancellations, and nonpositive quantities and prices.

**Monthly sales**: Compared gross sales, units sold, and invoice counts over time.

**Product performance**: Identified the top 10 products by gross sales.

**Country analysis**: Compared sales across countries.

**Customer analysis**: Ranked customers by sales value and average order value.

**RFM segmentation**: Grouped identifiable customers by recency, frequency, and monetary value.

# Methodology Notes

Gross sales = quantity x unit price.

Excluded from the main sales analysis: cancellation invoices (numbers beginning with "C"), nonpositive quantities, and nonpositive unit prices.

The dataset ends on December 9, 2011, so December is an incomplete month.

RFM thresholds were exploratory and should not be read as validated predictions of customer churn.
Dataset

Online Retail Dataset, UCI Machine Learning Repository. Transactions from December 2010 through December 2011.

# Project Files
sql/analysis_queries.sql: SQL analysis queries

Retail_Sales_Customer_Insights.xlsx: Excel analysis and dashboard

Dashboard.png — Dashboard screenshots
