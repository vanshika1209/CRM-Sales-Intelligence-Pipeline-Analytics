CREATE TABLE accounts (
    account VARCHAR(100) PRIMARY KEY,
    sector VARCHAR(100),
    year_established INT,
    revenue DECIMAL(12,2),   -- revenue in millions USD
    employees INT,
    office_location VARCHAR(100),
    subsidiary_of VARCHAR(100)
);

CREATE TABLE products (
    product VARCHAR(100) PRIMARY KEY,
    series VARCHAR(100),
    sales_price DECIMAL(10,2)
);

CREATE TABLE sales_teams (
    sales_agent VARCHAR(100) PRIMARY KEY,
    manager VARCHAR(100),
    regional_office VARCHAR(100)
);

CREATE TABLE sales_pipeline (
    opportunity_id VARCHAR(50) PRIMARY KEY,
    sales_agent VARCHAR(100),
    product VARCHAR(100),
    account VARCHAR(100),
    deal_stage VARCHAR(50),
    engage_date DATE,
    close_date DATE,
    close_value DECIMAL(12,2),

    FOREIGN KEY (sales_agent) REFERENCES sales_teams(sales_agent),
    FOREIGN KEY (product) REFERENCES products(product),
    FOREIGN KEY (account) REFERENCES accounts(account)
);

--How much revenue has the company generated from closed deals?
SELECT 
    SUM(close_value) AS total_sales
FROM sales_pipeline
WHERE deal_stage = 'Won';

--What is the average value of a successful deal?
SELECT 
    AVG(close_value) AS avg_deal_value
FROM sales_pipeline
WHERE deal_stage = 'Won';

--How efficiently does the company convert opportunities into sales?
SELECT 
    COUNT(CASE WHEN deal_stage='Won' THEN 1 END)*100.0 /
    COUNT(*) AS win_rate
FROM sales_pipeline;

--What is the average week to close a deal?
SELECT 
    ROUND(AVG((close_date - engage_date)/7.0), 2) AS avg_weeks_to_close
FROM sales_pipeline
WHERE deal_stage IN ('Won','Lost')
AND close_date IS NOT NULL
AND engage_date IS NOT NULL;

--Which sales manager generates the most revenue?
SELECT 
    st.manager,
    SUM(sp.close_value) AS total_sales
FROM sales_pipeline sp
JOIN sales_teams st
ON sp.sales_agent = st.sales_agent
WHERE sp.deal_stage='Won'
GROUP BY st.manager
ORDER BY total_sales DESC;

--Which agents bring the most revenue?
SELECT 
    sales_agent,
    SUM(close_value) AS total_sales
FROM sales_pipeline
WHERE deal_stage='Won'
GROUP BY sales_agent
ORDER BY total_sales DESC;

--Which products generate the most sales?
SELECT 
    product,
    SUM(close_value) AS total_sales
FROM sales_pipeline
WHERE deal_stage='Won'
GROUP BY product
ORDER BY total_sales DESC;

--Which industries generate the most revenue?
SELECT 
    a.sector,
    SUM(sp.close_value) AS revenue
FROM sales_pipeline sp
JOIN accounts a
ON sp.account = a.account
WHERE sp.deal_stage='Won'
GROUP BY a.sector
ORDER BY revenue DESC;

--How many deals are currently in the pipeline?
SELECT 
    deal_stage,
    COUNT(*) AS opportunities
FROM sales_pipeline
GROUP BY deal_stage;

--Do larger companies generate larger deals?
SELECT 
    CASE 
        WHEN employees < 100 THEN 'Small'
        WHEN employees BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'Large'
    END AS company_size,
    AVG(sp.close_value) AS avg_revenue
FROM sales_pipeline sp
JOIN accounts a
ON sp.account = a.account
WHERE sp.deal_stage='Won'
GROUP BY company_size;

--Conversion rate by product
SELECT 
    product,
    COUNT(CASE WHEN deal_stage='Won' THEN 1 END)*100.0 /
    COUNT(CASE WHEN deal_stage IN ('Won','Lost') THEN 1 END) AS conversion_rate
FROM sales_pipeline
GROUP BY product;

--How is revenue growing each quarter?
WITH revenue_by_quarter AS (
    SELECT 
        EXTRACT(YEAR FROM close_date) AS year,
        EXTRACT(QUARTER FROM close_date) AS quarter,
        SUM(close_value) AS revenue
    FROM sales_pipeline
    WHERE deal_stage = 'Won'
    GROUP BY 1,2
),

lagged AS (
    SELECT 
        year,
        quarter,
        revenue,
        LAG(revenue) OVER (ORDER BY year, quarter) AS prev_revenue
    FROM revenue_by_quarter
)

SELECT 
    year,
    quarter,
    revenue,
    prev_revenue,
    ROUND((revenue - prev_revenue)*100.0 / prev_revenue, 2) AS qoq_growth
FROM lagged;

--New opportunities for year 2017 Q4 and manager melvin marxen
SELECT 
    count(sp.opportunity_id) AS opp
FROM sales_pipeline sp
JOIN sales_teams st
ON sp.sales_agent = st.sales_agent
WHERE st.manager = 'Melvin Marxen'
AND EXTRACT(YEAR FROM sp.engage_date) = 2017
AND EXTRACT(QUARTER FROM sp.engage_date) = 4;

--How opportunities increasing each quarter (qoq opportunities)
WITH opps AS (
    SELECT 
        EXTRACT(YEAR FROM engage_date) AS year,
        EXTRACT(QUARTER FROM engage_date) AS quarter,
        COUNT(*) AS opportunities
    FROM sales_pipeline
    GROUP BY 1,2
),

lagged AS (
    SELECT *,
    LAG(opportunities) OVER (ORDER BY year, quarter) AS prev_opps
    FROM opps
)

SELECT *,
ROUND((opportunities - prev_opps)*100.0/prev_opps,2) AS qoq_growth
FROM lagged;

--How different products perform each quarter?
WITH product_qtr AS (
    SELECT 
        product,
        EXTRACT(YEAR FROM close_date) AS year,
        EXTRACT(QUARTER FROM close_date) AS quarter,
        SUM(close_value) AS revenue
    FROM sales_pipeline
    WHERE deal_stage = 'Won'
    GROUP BY product, year, quarter
),

lagged AS (
    SELECT 
        *,
        LAG(revenue) OVER (
            PARTITION BY product 
            ORDER BY year, quarter
        ) AS prev_revenue
    FROM product_qtr
)

SELECT 
    product,
    year,
    quarter,
    revenue,
    prev_revenue,
    ROUND(
        (revenue - prev_revenue) * 100.0 / NULLIF(prev_revenue, 0),
        2
    ) AS qoq_growth
FROM lagged
WHERE prev_revenue IS NOT NULL
ORDER BY product, year, quarter;