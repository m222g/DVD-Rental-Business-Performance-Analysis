-- Rental info

CREATE OR REPLACE VIEW `dvd222.dvd.store_rentals` AS
  SELECT
    r.rental_id,
    r.customer_id,
    r.rental_date,
    i.inventory_id,
    i.film_id,
    i.store_id
  FROM `dvd222.dvd.rental` r
  JOIN `dvd222.dvd.inventory` i ON r.inventory_id = i.inventory_id;


-- Payment info

CREATE OR REPLACE VIEW `dvd222.dvd.payment_info` AS
  SELECT
      p.payment_id,
      p.customer_id,
      p.rental_id,
      p.amount,
      CAST(p.payment_date AS TIMESTAMP) AS payment_date,
      sr.store_id,
      sr.film_id
  FROM `dvd222.dvd.payment` p
  JOIN `dvd222.dvd.store_rentals` sr ON p.rental_id = sr.rental_id;


-- Customer spending

CREATE OR REPLACE VIEW `dvd222.dvd.customer_spending` AS
  SELECT
    customer_id,
    SUM(amount) AS total_spent,
    COUNT(rental_id) AS total_rentals
  FROM `dvd222.dvd.payment_info`
  GROUP BY customer_id;


-- Film performance

CREATE OR REPLACE VIEW `dvd222.dvd.film_performance` AS
  SELECT
    film_id,
    COUNT(rental_id) AS rental_count,
    SUM(amount) AS revenue
  FROM `dvd222.dvd.payment_info`
  GROUP BY film_id;


-- Store performance - rentals per store

SELECT 
    store_id,
    COUNT(rental_id) AS total_transactions,
    ROUND(SUM(amount), 2) AS total_revenue,
    ROUND(SUM(amount) / COUNT(rental_id), 2) AS revenue_per_rental,
    ROUND(SUM(amount) / SUM(SUM(amount)) OVER (), 4) AS revenue_share
FROM `dvd222.dvd.payment_info`
GROUP BY store_id
ORDER BY total_revenue DESC;


-- Customer Segmentation
    -- High value $4000+
    -- Mid value $2501-4000
    -- Low value <= $2500

SELECT 
    CASE 
        WHEN total_spent > 4000 THEN 'High Value'
        WHEN total_spent > 2500 THEN 'Mid Value'
        ELSE 'Low Value'
    END AS customer_segment,

    COUNT(*) as num_customers,
    ROUND(SUM(total_spent), 2) as total_revenue,
    SUM(total_rentals) as total_transactions,
    ROUND(AVG(total_spent), 2) AS avg_spent_per_customer

FROM `dvd222.dvd.customer_spending`
GROUP BY customer_segment
ORDER BY total_revenue DESC;


-- Revenue concentration 

WITH customer_totals AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM `dvd222.dvd.payment_info`
    GROUP BY customer_id
),

top_customers AS (
  SELECT 
    *
  FROM customer_totals
  ORDER BY total_spent DESC
  LIMIT 10
  )
SELECT
  ROUND(SUM(total_spent), 2) AS top_10_revenue,
  ROUND(100 * SUM(total_spent) / (SELECT SUM(amount) FROM `dvd222.dvd.payment_info`), 2
  ) AS revenue_percent
FROM top_customers;


-- Film rental efficiency

SELECT 
    f.title,
    fp.rental_count,
    ROUND(fp.revenue, 2) as total_revenue,
    ROUND(fp.revenue / fp.rental_count, 2) AS revenue_per_rental
FROM `dvd222.dvd.film_performance` fp
JOIN `dvd222.dvd.film` f 
ON fp.film_id = f.film_id
ORDER BY revenue_per_rental DESC
LIMIT 10;


-- Monthly revenue trend

SELECT 
    DATE_TRUNC(payment_date, MONTH) AS month,
    SUM(amount) AS total_revenue,
    ROUND(AVG(amount), 2) AS avg_payment
FROM `dvd222.dvd.payment_info`
GROUP BY month
ORDER BY month;


-- Serves as an executive dashboard for store performance

CREATE OR REPLACE VIEW `dvd222.dvd.store_performance` AS
SELECT 
    store_id,
    COUNT(rental_id) AS total_rentals,
    SUM(amount) AS total_revenue,
    ROUND(SUM(amount) / COUNT(rental_id), 2) AS revenue_per_rental,
    ROUND(SUM(amount) / SUM(SUM(amount)) OVER (), 4) AS revenue_share
FROM `dvd222.dvd.payment_info`
GROUP BY store_id;








