-- ============================================
-- SQL Analysis of E-Commerce Order Data
-- Dataset: 1,200 orders (SQLite)
-- ============================================

-- ============================================
-- 1. OVERVIEW
-- ============================================
SELECT COUNT(*) AS total_orders,
       SUM(TotalPrice) AS total_revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value,
       MIN(TotalPrice) AS smallest_order,
       MAX(TotalPrice) AS largest_order
FROM orders;

-- ============================================
-- 2. ORDER STATUS & FULFILLMENT HEALTH
-- ============================================
SELECT OrderStatus, COUNT(*) AS order_count
FROM orders
GROUP BY OrderStatus
ORDER BY order_count DESC;

-- as a percentage of total
SELECT OrderStatus, COUNT(*) AS count,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2) AS pct_of_total
FROM orders
GROUP BY OrderStatus;

-- ============================================
-- 3. PRODUCT PERFORMANCE
-- ============================================
SELECT Product, SUM(TotalPrice) AS revenue, COUNT(*) AS order_count
FROM orders
GROUP BY Product
ORDER BY revenue DESC;

-- ============================================
-- 4. PAYMENT METHOD BEHAVIOR
-- ============================================
SELECT PaymentMethod, ROUND(AVG(TotalPrice), 2) AS avg_order_value, COUNT(*) AS order_count
FROM orders
GROUP BY PaymentMethod
ORDER BY avg_order_value DESC;

-- ============================================
-- 5. REVENUE TREND BY MONTH
-- ============================================
SELECT strftime('%Y-%m', Date) AS month, SUM(TotalPrice) AS revenue, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month;

-- earliest 5 months
SELECT strftime('%Y-%m', Date) AS month, SUM(TotalPrice) AS revenue, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month
LIMIT 5;

-- most recent 5 months
SELECT strftime('%Y-%m', Date) AS month, SUM(TotalPrice) AS revenue, COUNT(*) AS order_count
FROM orders
GROUP BY month
ORDER BY month DESC
LIMIT 5;

-- ============================================
-- 6. REFERRAL SOURCE PERFORMANCE
-- ============================================
SELECT ReferralSource,
       COUNT(*) AS order_count,
       SUM(TotalPrice) AS revenue,
       ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY ReferralSource
ORDER BY revenue DESC;

-- ============================================
-- 7. COUPON USAGE IMPACT
-- ============================================
-- NOTE: "no coupon" rows are stored as the literal text 'No Coupon',
-- not NULL -- confirmed by inspecting distinct values first:
SELECT CouponCode_Cleaned, COUNT(*) AS count
FROM orders
GROUP BY CouponCode_Cleaned
ORDER BY count DESC;

SELECT
  CASE WHEN CouponCode_Cleaned = 'No Coupon' THEN 'No Coupon' ELSE 'Used Coupon' END AS coupon_status,
  COUNT(*) AS order_count,
  ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY coupon_status;

-- ============================================
-- 8. ORDER VALUE TIERS
-- ============================================
SELECT
  CASE
    WHEN TotalPrice > 2000 THEN 'High Value'
    WHEN TotalPrice > 500 THEN 'Mid Value'
    ELSE 'Low Value'
  END AS order_tier,
  COUNT(*) AS orders,
  SUM(TotalPrice) AS revenue
FROM orders
GROUP BY order_tier
ORDER BY revenue DESC;

-- ============================================
-- 9. TOP 10 CUSTOMERS BY LIFETIME VALUE
-- ============================================
SELECT CustomerID, COUNT(*) AS total_orders, SUM(TotalPrice) AS lifetime_value
FROM orders
GROUP BY CustomerID
ORDER BY lifetime_value DESC
LIMIT 10;

-- ============================================
-- 10. OUTLIER VALIDATION
-- ============================================
SELECT [Outlier Flag], COUNT(*) AS order_count, ROUND(AVG(TotalPrice), 2) AS avg_order_value
FROM orders
GROUP BY [Outlier Flag];

-- ============================================
-- 11. DATA CLEANING NOTE
-- ============================================
-- A phantom row (leftover Excel COUNTA total) was found and removed:
-- SELECT * FROM orders WHERE Product IS NULL;   -- confirmed the bad row
-- DELETE FROM orders WHERE Product IS NULL;     -- removed it
