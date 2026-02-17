1) Sanity checks
-- Row count
SELECT COUNT(*) AS total_rows
FROM orders;

-- Preview
SELECT *
FROM orders
LIMIT 20;

2) Total revenue
-- Total revenue
SELECT ROUND(SUM("Sales"), 2) AS total_revenue
FROM orders;

3) Revenue by region
-- Revenue by region
SELECT
  "Region",
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY "Region"
ORDER BY revenue DESC;

4) Revenue by month (dd/mm/yyyy)
-- Monthly order volume trend (normalized from inconsistent data formats)
SELECT
  substr(TRIM("Order Date"), -4) || '-' ||
  printf(
    '%02d',
    CAST(
      substr(
        substr(TRIM("Order Date"), instr(TRIM("Order Date"), '/') + 1),
        1,
        instr(substr(TRIM("Order Date"), instr(TRIM("Order Date"), '/') + 1), '/') - 1
      ) AS INTEGER
    )
  ) AS year_month,
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY year_month
ORDER BY year_month;

5) Revenue by category + sub-category
-- Revenue by category
SELECT
  "Category",
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY "Category"
ORDER BY revenue DESC;

-- Revenue by sub-category
SELECT
  "Sub-Category",
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY "Sub-Category"
ORDER BY revenue DESC;

6) Top 10 customers
-- Top 10 customers by revenue
SELECT
  "Customer Name",
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY "Customer Name"
ORDER BY revenue DESC
LIMIT 10;

7) Monthly revenue by region
-- Monthly revenue by region
SELECT
  substr("Order Date", 7, 4) || '-' || substr("Order Date", 1, 2) AS year_month,
  "Region",
  ROUND(SUM("Sales"), 2) AS revenue
FROM orders
GROUP BY year_month, "Region"
ORDER BY year_month, revenue DESC;

8) Orders per month by region
-- Orders per month by region (normalized date parsing)
SELECT
  substr(TRIM("Order Date"), -4) || '-' ||
  printf(
    '%02d',
    CAST(
      substr(
        substr(TRIM("Order Date"), instr(TRIM("Order Date"), '/') + 1),
        1,
        instr(substr(TRIM("Order Date"), instr(TRIM("Order Date"), '/') + 1), '/') - 1
      ) AS INTEGER
    )
  ) AS year_month,
  "Region",
  COUNT(*) AS orders
FROM orders
GROUP BY year_month, "Region"
ORDER BY year_month, orders DESC;
