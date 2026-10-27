


SELECT COUNT(*) AS total_rows
    -> FROM online_retail;


SELECT *
    -> FROM online_retail
    -> LIMIT 5;


SELECT
    ->     MIN(InvoiceDate) AS first_date,
    ->     MAX(InvoiceDate) AS last_date,
    ->     COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    ->     COUNT(DISTINCT StockCode) AS unique_products,
    ->     COUNT(DISTINCT CustomerID) AS unique_customers
    -> FROM online_retail;


SELECT
    ->     SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END)
    ->         AS missing_customer_ids,
    ->     SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END)
    ->         AS missing_descriptions,
    ->     SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END)
    ->         AS missing_dates,
    ->     SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END)
    ->         AS missing_prices
    -> FROM online_retail;


SELECT
    ->     SUM(CASE WHEN Quantity <= 0 THEN 1 ELSE 0 END)
    ->         AS nonpositive_quantity_rows,
    ->     SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END)
    ->         AS nonpositive_price_rows
    -> FROM online_retail;


SELECT
    ->     COUNT(*) AS canceled_invoice_rows
    -> FROM online_retail
    -> WHERE InvoiceNo LIKE 'C%';


SELECT
    ->     InvoiceNo,
    ->     StockCode,
    ->     Description,
    ->     Quantity,
    ->     UnitPrice,
    ->     InvoiceDate
    -> FROM online_retail
    -> WHERE InvoiceNo LIKE 'C%'
    -> LIMIT 10;


SELECT
    ->     InvoiceNo,
    ->     StockCode,
    ->     Description,
    ->     Quantity,
    ->     UnitPrice
    -> FROM online_retail
    -> WHERE UnitPrice <= 0
    -> ORDER BY UnitPrice
    -> LIMIT 15;


SELECT
    ->     CASE
    ->         WHEN InvoiceNo LIKE 'C%' THEN 'Canceled invoice'
    ->         ELSE 'Other invoice'
    ->     END AS invoice_type,
    ->     COUNT(*) AS total_rows,
    ->     SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END)
    ->         AS negative_quantity_rows
    -> FROM online_retail
    -> GROUP BY
    ->     CASE
    ->         WHEN InvoiceNo LIKE 'C%' THEN 'Canceled invoice'
    ->         ELSE 'Other invoice'
    ->     END;


SELECT
    ->     DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
    ->     COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    -> GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
    -> ORDER BY sales_month;


SELECT
    ->     StockCode,
    ->     Description,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    -> GROUP BY StockCode, Description
    -> ORDER BY gross_sales DESC
    -> LIMIT 10;


SELECT
    ->     StockCode,
    ->     Description,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    ->   AND StockCode NOT IN ('DOT', 'POST', 'M', 'D')
    -> GROUP BY StockCode, Description
    -> ORDER BY gross_sales DESC
    -> LIMIT 10;


SELECT
    ->     Country,
    ->     COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    -> GROUP BY Country
    -> ORDER BY gross_sales DESC
    -> LIMIT 10;


SELECT
    ->     CustomerID,
    ->     COUNT(DISTINCT InvoiceNo) AS total_orders,
    ->     SUM(Quantity) AS units_purchased,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    ->   AND CustomerID IS NOT NULL
    -> GROUP BY CustomerID
    -> ORDER BY gross_sales DESC
    -> LIMIT 10;


SELECT
    ->     CustomerID,
    ->     COUNT(DISTINCT InvoiceNo) AS total_orders,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales,
    ->     ROUND(
    ->         SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo),
    ->         2
    ->     ) AS average_order_value
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    ->   AND CustomerID IS NOT NULL
    -> GROUP BY CustomerID
    -> ORDER BY average_order_value DESC
    -> LIMIT 10;


SELECT
    ->     CustomerID,
    ->     DATEDIFF(
    ->         (SELECT MAX(InvoiceDate) FROM online_retail),
    ->         MAX(InvoiceDate)
    ->     ) AS recency_days,
    ->     COUNT(DISTINCT InvoiceNo) AS frequency,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS monetary_value
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    ->   AND CustomerID IS NOT NULL
    -> GROUP BY CustomerID
    -> ORDER BY monetary_value DESC
    -> LIMIT 10;


SELECT
    ->     COUNT(*) AS total_customers,
    ->     MIN(recency_days) AS min_recency,
    ->     MAX(recency_days) AS max_recency,
    ->     MIN(frequency) AS min_frequency,
    ->     MAX(frequency) AS max_frequency,
    ->     ROUND(MIN(monetary_value), 2) AS min_spend,
    ->     ROUND(MAX(monetary_value), 2) AS max_spend
    -> FROM (
    ->     SELECT
    ->         CustomerID,
    ->         DATEDIFF(
    ->             (SELECT MAX(InvoiceDate) FROM online_retail),
    ->             MAX(InvoiceDate)
    ->         ) AS recency_days,
    ->         COUNT(DISTINCT InvoiceNo) AS frequency,
    ->         SUM(Quantity * UnitPrice) AS monetary_value
    ->     FROM online_retail
    ->     WHERE InvoiceNo NOT LIKE 'C%'
    ->       AND Quantity > 0
    ->       AND UnitPrice > 0
    ->       AND CustomerID IS NOT NULL
    ->     GROUP BY CustomerID
    -> ) AS customer_metrics;


WITH customer_metrics AS (
    ->     SELECT
    ->         CustomerID,
    ->         DATEDIFF(
    ->             (SELECT MAX(InvoiceDate) FROM online_retail),
    ->             MAX(InvoiceDate)
    ->         ) AS recency_days,
    ->         COUNT(DISTINCT InvoiceNo) AS frequency,
    ->         SUM(Quantity * UnitPrice) AS monetary_value
    ->     FROM online_retail
    ->     WHERE InvoiceNo NOT LIKE 'C%'
    ->       AND Quantity > 0
    ->       AND UnitPrice > 0
    ->       AND CustomerID IS NOT NULL
    ->     GROUP BY CustomerID
    -> ),
    -> rfm_scores AS (
    ->     SELECT
    ->         CustomerID,
    ->         recency_days,
    ->         frequency,
    ->         ROUND(monetary_value, 2) AS monetary_value,
    ->         6 - NTILE(5) OVER (
    ->             ORDER BY recency_days
    ->         ) AS recency_score,
    ->         NTILE(5) OVER (
    ->             ORDER BY frequency
    ->         ) AS frequency_score,
    ->         NTILE(5) OVER (
    ->             ORDER BY monetary_value
    ->         ) AS monetary_score
    ->     FROM customer_metrics
    -> )
    -> SELECT *
    -> FROM rfm_scores
    -> ORDER BY monetary_value DESC
    -> LIMIT 10;


WITH customer_metrics AS (
    ->     SELECT
    ->         CustomerID,
    ->         DATEDIFF(
    ->             (SELECT MAX(InvoiceDate) FROM online_retail),
    ->             MAX(InvoiceDate)
    ->         ) AS recency_days,
    ->         COUNT(DISTINCT InvoiceNo) AS frequency,
    ->         SUM(Quantity * UnitPrice) AS monetary_value
    ->     FROM online_retail
    ->     WHERE InvoiceNo NOT LIKE 'C%'
    ->       AND Quantity > 0
    ->       AND UnitPrice > 0
    ->       AND CustomerID IS NOT NULL
    ->     GROUP BY CustomerID
    -> ),
    -> rfm_scores AS (
    ->     SELECT
    ->         CustomerID,
    ->         6 - NTILE(5) OVER (ORDER BY recency_days) AS recency_score,
    ->         NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
    ->         NTILE(5) OVER (ORDER BY monetary_value) AS monetary_score
    ->     FROM customer_metrics
    -> ),
    -> customer_segments AS (
    ->     SELECT
    ->         CustomerID,
    ->         CASE
    ->             WHEN recency_score >= 4
    ->              AND frequency_score >= 4
    ->              AND monetary_score >= 4
    ->                 THEN 'High-value active'
    ->             WHEN recency_score <= 2
    ->                 THEN 'Needs re-engagement'
    ->             ELSE 'Other customers'
    ->         END AS customer_segment
    ->     FROM rfm_scores
    -> )
    -> SELECT
    ->     customer_segment,
    ->     COUNT(*) AS customer_count
    -> FROM customer_segments
    -> GROUP BY customer_segment
    -> ORDER BY customer_count DESC;


SELECT
    ->     DATE_FORMAT(InvoiceDate, '%Y-%m') AS sales_month,
    ->     COUNT(DISTINCT InvoiceNo) AS unique_invoices,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    -> GROUP BY DATE_FORMAT(InvoiceDate, '%Y-%m')
    -> ORDER BY sales_month;


SELECT
    ->     StockCode,
    ->     Description,
    ->     SUM(Quantity) AS units_sold,
    ->     ROUND(SUM(Quantity * UnitPrice), 2) AS gross_sales
    -> FROM online_retail
    -> WHERE InvoiceNo NOT LIKE 'C%'
    ->   AND Quantity > 0
    ->   AND UnitPrice > 0
    ->   AND StockCode NOT IN ('DOT', 'POST', 'M', 'D')
    -> GROUP BY StockCode, Description
    -> ORDER BY gross_sales DESC
    -> LIMIT 10;


WITH customer_metrics AS (
    ->     SELECT
    ->         CustomerID,
    ->         DATEDIFF(
    ->             (SELECT MAX(InvoiceDate) FROM online_retail),
    ->             MAX(InvoiceDate)
    ->         ) AS recency_days,
    ->         COUNT(DISTINCT InvoiceNo) AS frequency,
    ->         SUM(Quantity * UnitPrice) AS monetary_value
    ->     FROM online_retail
    ->     WHERE InvoiceNo NOT LIKE 'C%'
    ->       AND Quantity > 0
    ->       AND UnitPrice > 0
    ->       AND CustomerID IS NOT NULL
    ->     GROUP BY CustomerID
    -> ),
    -> rfm_scores AS (
    ->     SELECT
    ->         CustomerID,
    ->         6 - NTILE(5) OVER (ORDER BY recency_days) AS recency_score,
    ->         NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
    ->         NTILE(5) OVER (ORDER BY monetary_value) AS monetary_score
    ->     FROM customer_metrics
    -> ),
    -> customer_segments AS (
    ->     SELECT
    ->         CustomerID,
    ->         CASE
    ->             WHEN recency_score >= 4
    ->              AND frequency_score >= 4
    ->              AND monetary_score >= 4
    ->                 THEN 'High-value active'
    ->             WHEN recency_score <= 2
    ->                 THEN 'Needs re-engagement'
    ->             ELSE 'Other customers'
    ->         END AS customer_segment
    ->     FROM rfm_scores
    -> )
    -> SELECT
    ->     customer_segment,
    ->     COUNT(*) AS customer_count,
    ->     ROUND(
    ->         COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
    ->         2
    ->     ) AS customer_percentage
    -> FROM customer_segments
    -> GROUP BY customer_segment
    -> ORDER BY customer_count DESC;
