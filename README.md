# retail-sales-customer-insights

# Project Overview

This project analyzes online retail transaction data using MySQL and Microsoft Excel to identify sales trends, top-performing products, geographic sales patterns, and customer segments.

The goal was to practice data cleaning, SQL querying, customer analysis, and presenting business insights through an Excel dashboard.

# Tools Used

MySQL 8.0: Data cleaning, aggregation, filtering, joins and customer analysis

Microsoft Excel: Data formatting, charts and dashboard creation

SQL: Sales metrics, product rankings and RFM customer segmentation

# Analysis Performed

Data cleaning: Investigated missing customer IDs, cancellations, nonpositive quantities and nonpositive prices.

Monthly sales: Compared gross sales, units sold and invoice counts over time.

Product performance: Identified the top 10 products by gross sales.

Country analysis: Compared sales across countries.

Customer analysis: Ranked customers by sales value and average order value.

RFM segmentation: Grouped identifiable customers using recency, frequency and monetary value.

# Key Findings

Total gross sales were approximately £10.67 million under the project's transaction filters.

November 2011 was the strongest month, with approximately £1.51 million in gross sales.

Regency Cakestand 3 Tier ranked first among the top 10 products by gross sales, generating £174,484.74.

The exploratory RFM analysis classified 905 customers as high-value active and 1,734 customers as needing re-engagement.

# Methodology Notes

Gross sales were calculated as quantity multiplied by unit price. Transactions with cancellation invoice numbers beginning with C, nonpositive quantities, and nonpositive unit prices were excluded from the main sales analysis.

The dataset ends on December 9, 2011, making December an incomplete month. Customer segmentation thresholds were exploratory and should not be interpreted as validated predictions of customer churn.

# Dataset

Source: Online Retail Dataset — UCI Machine Learning Repository

The original dataset contains online retail transactions from December 2010 through December 2011.

# Project Files

sql/analysis_queries.sql — SQL analysis queries

Retail_Sales_Customer_Insights.xlsx — Excel analysis and dashboard

screenshots/ — Dashboard screenshots, if included
