-- Remove carriage-return characters from country names
UPDATE online_retail
SET Country = TRIM(TRAILING '\r' FROM Country);

-- Handle missing CustomerID values
CustomerID = NULLIF(@CustomerID, '');

-- Filter out invalid or unusual transactions
WHERE InvoiceNo NOT LIKE 'C%'
  AND Quantity > 0
  AND UnitPrice > 0
