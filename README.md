# CRM-Sales-Intelligence-Pipeline-Analytics
End-to-end CRM sales analytics project using PostgreSQL, CSV datasets, and Power BI to analyze pipeline performance, revenue trends, and sales efficiency through advanced SQL and interactive dashboards.

<img width="1278" height="718" alt="image" src="https://github.com/user-attachments/assets/5162ec4d-77f4-4b7f-b496-f85bbd27492d" />
<img width="1283" height="715" alt="image" src="https://github.com/user-attachments/assets/6dce4917-1427-4439-851c-335d2f60f301" />
<img width="1279" height="723" alt="image" src="https://github.com/user-attachments/assets/9ed681bd-052c-4ab4-9975-4d6a73b5d4e0" />
<img width="1276" height="719" alt="image" src="https://github.com/user-attachments/assets/8dd5c293-5d1f-4fab-a3a8-65e673b5ce53" />
<img width="1273" height="707" alt="image" src="https://github.com/user-attachments/assets/f3123ecb-ec9e-4dfa-a686-dda736512173" />

# 📊 CRM Sales Analytics Project (PostgreSQL + Power BI)

## 🚀 Project Overview

This project is a **professional-grade CRM Sales Analytics solution** built using **PostgreSQL, CSV datasets, and Power BI**. It simulates a real-world sales environment where organizations track accounts, products, sales teams, and deal pipelines to generate actionable business insights.

The project demonstrates **end-to-end data analysis**, including:

* Data modeling (relational schema)
* SQL-based analytics
* KPI generation
* Business intelligence dashboarding (Power BI)

---

## 🗂️ Project Structure

```
📦 CRM-Sales-Analytics
 ┣ 📜 crmsql.sql              # Database schema + analytical SQL queries
 ┣ 📊 crm_dash.pbix          # Power BI dashboard file
 ┣ 📁 data/
 ┃ ┣ accounts.csv
 ┃ ┣ products.csv
 ┃ ┣ sales_pipeline.csv
 ┃ ┣ sales_teams.csv
 ┃ ┗ data_dictionary.csv
 ┗ 📄 README.md
```

---

## 🧱 Data Model (Database Schema)

The project uses a **relational database design** with the following tables:

### 1. Accounts

Stores company/client information:

* Industry sector
* Revenue (in millions USD)
* Number of employees
* Location and parent company

### 2. Products

Contains product catalog:

* Product name
* Series/category
* Sales price

### 3. Sales Teams

Defines organizational hierarchy:

* Sales agents
* Reporting managers
* Regional offices

### 4. Sales Pipeline

Core transactional table:

* Opportunities (deals)
* Deal stages (Won, Lost, etc.)
* Engagement and closing dates
* Revenue generated

📌 Relationships:

* `sales_pipeline.sales_agent → sales_teams.sales_agent`
* `sales_pipeline.product → products.product`
* `sales_pipeline.account → accounts.account`

---

## 📈 Key Business KPIs

The SQL analysis focuses on critical sales metrics:

### 💰 Revenue Metrics

* Total revenue from closed deals
* Average deal value
* Revenue by product, manager, and industry

### 🎯 Sales Performance

* Win rate (conversion efficiency)
* Top-performing sales agents
* Manager-wise revenue contribution

### ⏱️ Sales Efficiency

* Average time to close deals (in weeks)
* Pipeline distribution across deal stages

### 📊 Growth Analytics

* Quarterly revenue growth (QoQ)
* Opportunity growth trends
* Product-wise performance over time

### 🏢 Customer Insights

* Revenue by industry sector
* Deal size vs company size analysis

---

## 🔍 Example Insights Generated

* Identify **top revenue-generating products and industries**
* Evaluate **sales team performance and hierarchy impact**
* Track **quarter-over-quarter growth trends**
* Measure **conversion rates and sales efficiency**
* Analyze whether **larger companies yield higher deal values**

---

## 📊 Power BI Dashboard

The Power BI dashboard (`crm_dash.pbix`) provides an interactive visualization layer with:

### Dashboard Features:

* KPI cards (Revenue, Win Rate, Avg Deal Size)
* Time-series analysis (Quarterly trends)
* Sales pipeline funnel visualization
* Product and industry breakdowns
* Sales agent & manager performance views

### Business Value:

* Enables **real-time decision making**
* Highlights **bottlenecks in the sales pipeline**
* Helps optimize **sales strategy and targeting**

---

## ⚙️ How to Run the Project

### 1. Set Up Database

```sql
-- Run the SQL script
\i crmsql.sql
```

### 2. Load CSV Data

Import all CSV files into corresponding tables:

* accounts.csv → accounts
* products.csv → products
* sales_teams.csv → sales_teams
* sales_pipeline.csv → sales_pipeline

### 3. Execute Analysis Queries

Run the queries provided in `crmsql.sql` to generate insights.

### 4. Open Power BI Dashboard

* Open `crm_dash.pbix` in Power BI Desktop
* Connect to your PostgreSQL database (if required)
* Refresh data

---

## 🧠 Skills Demonstrated

* Advanced SQL (joins, aggregations, window functions, CTEs)
* Data modeling & normalization
* Business KPI design
* Time-series and cohort analysis
* Data visualization (Power BI)
* Analytical thinking for sales optimization

---

## 📌 Key SQL Techniques Used

* `JOIN` for relational analysis
* `CASE WHEN` for segmentation
* `CTEs` for structured queries
* `WINDOW FUNCTIONS (LAG)` for growth calculations
* `DATE FUNCTIONS` for time-based analysis
* `AGGREGATIONS` for KPI computation

---

## 🎯 Use Cases

This project is ideal for:

* CRM analytics
* Sales performance tracking
* Business intelligence portfolios
* Data analyst / BI developer interviews

---

## 📎 Future Enhancements

* Add forecasting models (time-series prediction)
* Integrate customer lifetime value (CLV)
* Build real-time dashboards with streaming data
* Add machine learning for deal win prediction

---

## 👨‍💻 Author

Developed as a **data analytics portfolio project** showcasing real-world business problem solving using SQL and Power BI.

---

## ⭐ If You Like This Project

Give it a star ⭐ and feel free to fork or contribute!

---

