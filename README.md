# Coffee-sales-analysis
End-to-end coffee sales analytics project using PostgreSQL for data analysis and Power BI for interactive dashboard visualization.

☕ Coffee Sales Analysis
SQL + Power BI End-to-End Analytics Project
📌 Project Overview

This project analyzes 6 months of transactional coffee shop data using PostgreSQL to uncover revenue trends, customer behavior patterns, and product performance insights.

The goal of this project is to simulate a real-world business analytics scenario where raw transactional data is transformed into meaningful, decision-driven insights.

This project will also be extended into an interactive Power BI dashboard for business reporting and visualization.

🎯 Business Objectives

The analysis focuses on answering key business questions:

How are sales performing month-over-month?

Are orders and quantities growing consistently?

Do weekends outperform weekdays?

What are the peak revenue hours?

Which store locations generate the highest revenue?

Which product categories and products drive most of the sales?

How do daily sales compare to average performance?

🗂 Dataset Description

The dataset contains transactional-level data with the following fields:

Column	Description
transaction_id	Unique ID per transaction
transaction_date	Date of purchase
transaction_time	Time of purchase
store_location	Store branch location
product_category	Category of product
product_type	Specific product
transaction_qty	Quantity sold
unit_price	Price per unit
🛠 Tools & Technologies Used

PostgreSQL

SQL (CTEs, Window Functions, Aggregations)

DATE_TRUNC & EXTRACT

LAG() for Growth Analysis

CASE statements for classification

Power BI (upcoming dashboard phase)

📊 Analytical Approach

The project was structured into the following analytical layers:

1️⃣ Monthly Sales & Growth Analysis

Calculated total monthly revenue

Computed Month-over-Month (MoM) growth %

Identified upward and downward trends

2️⃣ Order & Quantity Trend Analysis

Monthly order volume

Quantity growth percentage

Performance momentum detection

3️⃣ Time-Based Performance Analysis

Weekday vs Weekend comparison

Peak sales hours

Daily sales benchmarking against average

4️⃣ Store-Level Performance

Total revenue by store location

Order contribution per branch

Location ranking by sales

5️⃣ Product Performance Analysis

Sales by product category

Top 10 revenue-generating products

Revenue concentration insights

📈 Key Insights

📊 Clear month-over-month growth trend observed.

🗓 Weekend sales consistently outperform weekdays.

⏰ Afternoon hours generate peak revenue.

🏪 One store location significantly outperforms others.

☕ A small group of top products contributes heavily to total sales.

📌 Daily performance varies significantly from average, indicating promotional or demand fluctuations.

💡 Skills Demonstrated

Writing production-ready SQL queries

Designing structured analytical workflows

Using Window Functions for business metrics

Growth rate calculations & performance benchmarking

Business storytelling through data

Preparing data for BI dashboard integration

📊 Next Phase – Power BI Dashboard

The next stage of this project involves:

Importing cleaned SQL outputs into Power BI

Building interactive dashboards

Creating KPI cards & trend visuals

Designing business-ready reports

Adding slicers and drill-down functionality

This will complete the full analytics pipeline:
Database → SQL Analysis → Visualization → Business Insights

🚀 Why This Project Matters

This project demonstrates my ability to:

Work with raw transactional datasets

Transform data into decision-making insights

Apply intermediate-to-advanced SQL concepts

Think from a business intelligence perspective

Build end-to-end analytical solutions


Create customer segmentation metrics

Implement performance forecasting models

⭐ If you found this project interesting, feel free to connect or provide feedback.
