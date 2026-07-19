# E-Commerce Order Data Analysis (Excel + SQL)

An analysis of a 1,200-order e-commerce dataset, done two ways: first as an exploratory data analysis (EDA) in Excel, then re-run and extended in SQL (SQLite) to validate the findings and go a step further with subqueries, CASE logic, and date-based trend analysis.

Showing both isn't redundant — it demonstrates the same analytical thinking translated across tools, and every SQL result here was checked against the matching Excel pivot table output to confirm accuracy.

## 📊 Dataset

- **Source:** Cleaned e-commerce order data (originally processed in Excel)
- **Rows:** 1,200 orders (1 erroneous row identified and removed during SQL validation)
- **Columns:** OrderID, Date, CustomerID, Product, Quantity, UnitPrice, ShippingAddress, PaymentMethod, OrderStatus, TrackingNumber, ItemsInCart, CouponCode_Cleaned, ReferralSource, TotalPrice, Outlier Flag
- **File:** [`ecommerce.db`](./ecommerce.db) — SQLite database

## 🔑 Key Findings

| Area | Finding |
|---|---|
| Revenue trend | Down ~13% over 30 months — driven by falling order value, not falling order volume |
| Order fulfillment | 41% of all orders end in cancellation or return |
| Customer loyalty | Top 10 customers by lifetime value are almost all one-time buyers |
| Referral channels | Instagram leads on both order volume and revenue |
| Coupons | Negligible effect on average order value (~1.3% difference) |
| Outlier validation | Flagged outliers (0.7% of orders) average 3.3x the typical order value |

Full write-up with all 11 sections: [`SQL_Analysis_Ecommerce_Writeup.docx`](./SQL_Analysis_Ecommerce_Writeup.docx)

## 📈 Excel EDA

The original exploratory analysis — data cleaning, pivot tables (orders by status, revenue by product, average order value by payment method, revenue by month), and outlier flagging — is included as [`Excel_EDA_Ecommerce.xlsx`](./Excel_EDA_Ecommerce.xlsx). This was the starting point for the SQL analysis above; every pivot table in this file has a matching SQL query in `queries.sql`.

## 🛠️ Tools & Skills

- **SQL (SQLite):** `SELECT`, `WHERE`, `GROUP BY`, `HAVING`, `ORDER BY`, `CASE`, aggregate functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`), subqueries, `strftime()` date functions
- **Data validation:** cross-checked every SQL result against a prior Excel EDA to confirm accuracy
- **Data cleaning:** identified and removed a phantom row via SQL

## 📁 Repo Structure

```
├── README.md
├── Excel_EDA_Ecommerce.xlsx             # Original Excel exploratory analysis
├── queries.sql                          # All SQL analysis queries, organized by section
├── ecommerce.db                         # SQLite database (same data as the Excel file)
└── SQL_Analysis_Ecommerce_Writeup.docx  # Full written SQL analysis
```

## ▶️ How to Run

1. Clone this repo
2. Open `ecommerce.db` in [DB Browser for SQLite](https://sqlitebrowser.org/) (or any SQLite client)
3. Run any query from `queries.sql` in the Execute SQL tab

## 👤 About

Analysis by Omolola Olasope, as part of an ongoing data analytics portfolio. See also the companion [Excel EDA](#) on this same dataset.
