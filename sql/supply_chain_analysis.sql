CREATE DATABASE supply_chain_analysis;

USE supply_chain_analysis;


SELECT COUNT(*) AS total_records
FROM supply_chain_python_import;

-- Identify which shipping modes have the highest late-delivery risk


USE supply_chain_analysis;

SELECT
    `Shipping Mode`,
    COUNT(*) AS Total_Records,
    SUM(`Late_delivery_risk`) AS Late_Risk_Records,
    ROUND(
        SUM(`Late_delivery_risk`) * 100.0 / COUNT(*),
        2
    ) AS Late_Risk_Percentage,
    ROUND(
        AVG(`Days for shipping (real)`), 2
    ) AS Avg_Actual_Shipping_Days,
    ROUND(
        AVG(`Days for shipment (scheduled)`), 2
    ) AS Avg_Scheduled_Shipping_Days
FROM supply_chain_python_import
GROUP BY `Shipping Mode`
ORDER BY Late_Risk_Percentage DESC;



-- Product Profitability Analysis


SELECT
    `Category Name`,
    COUNT(*) AS Total_Records,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    ROUND(AVG(`Order Profit Per Order`), 2) AS Average_Profit
FROM supply_chain_python_import
GROUP BY `Category Name`
ORDER BY Total_Profit DESC;



-- Which categories generate the most sales and profit?-- 


SELECT
    `Category Name`,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    ROUND(AVG(`Order Profit Per Order`), 2) AS Avg_Profit,
    COUNT(*) AS Total_Records
FROM supply_chain_python_import
GROUP BY `Category Name`
ORDER BY Total_Profit DESC;

-- Which products have the lowest total profit?


SELECT
    `Product Name`,
    `Category Name`,
    SUM(Sales) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    COUNT(*) AS Total_Records
FROM supply_chain_python_import
GROUP BY `Product Name`, `Category Name`
HAVING SUM(`Order Profit Per Order`) < 0
ORDER BY Total_Profit ASC
LIMIT 10;


-- Are higher discounts associated with lower profit?


SELECT
    CASE
        WHEN `Order Item Discount Rate` < 0.10 THEN 'Below 10%'
        WHEN `Order Item Discount Rate` < 0.20 THEN '10% to below 20%'
        WHEN `Order Item Discount Rate` < 0.30 THEN '20% to below 30%'
        ELSE '30% and above'
    END AS Discount_Group,
    COUNT(*) AS Total_Records,
    ROUND(AVG(`Order Item Discount Rate`) * 100, 2)
        AS Avg_Discount_Percent,
    ROUND(AVG(`Order Profit Per Order`), 2) AS Avg_Profit,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit
FROM supply_chain_python_import
GROUP BY Discount_Group
ORDER BY Avg_Discount_Percent;



-- Which markets generate the most revenue and profit?



SELECT
    Market,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    COUNT(DISTINCT `Order Id`) AS Unique_Orders
FROM supply_chain_python_import
GROUP BY Market
ORDER BY Total_Profit DESC;









-- How does business performance change over time?

 
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`order date (DateOrders)`, '%Y-%m-%d %H:%i:%s'),
        '%Y-%m'
    ) AS Order_Month,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    COUNT(DISTINCT `Order Id`) AS Unique_Orders
FROM supply_chain_python_import
GROUP BY Order_Month
ORDER BY Order_Month;

-- Which customer segments contribute the most profit? 


SELECT
    `Customer Segment`,
    COUNT(DISTINCT `Order Id`) AS Unique_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    ROUND(AVG(`Order Profit Per Order`), 2) AS Avg_Profit
FROM supply_chain_python_import
GROUP BY `Customer Segment`
ORDER BY Total_Profit DESC;



-- How are orders distributed across delivery and fulfillment statuses?


SELECT
    `Order Status`,
    COUNT(DISTINCT `Order Id`) AS Unique_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit
FROM supply_chain_python_import
GROUP BY `Order Status`
ORDER BY Unique_Orders DESC;


-- Which shipping modes exceed their scheduled shipping duration?


SELECT
    `Shipping Mode`,
    COUNT(*) AS Total_Records,
    ROUND(AVG(`Days for shipping (real)`), 2)
        AS Avg_Actual_Days,
    ROUND(AVG(`Days for shipment (scheduled)`), 2)
        AS Avg_Scheduled_Days,
    ROUND(
        AVG(
            `Days for shipping (real)`
            - `Days for shipment (scheduled)`
        ), 2
    ) AS Avg_Delay_Days,
    SUM(
        CASE
            WHEN `Days for shipping (real)`
                 > `Days for shipment (scheduled)`
            THEN 1 ELSE 0
        END
    ) AS Records_Exceeding_Schedule
FROM supply_chain_python_import
GROUP BY `Shipping Mode`
ORDER BY Avg_Delay_Days DESC;


-- Overall business KPIs


SELECT
    COUNT(*) AS Total_Records,
    COUNT(DISTINCT `Order Id`) AS Unique_Orders,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(`Order Profit Per Order`), 2) AS Total_Profit,
    ROUND(AVG(`Order Profit Per Order`), 2) AS Avg_Profit_Per_Record,
    ROUND(
        SUM(`Order Profit Per Order`) * 100.0
        / NULLIF(SUM(Sales), 0), 2
    ) AS Profit_To_Sales_Percent,
    SUM(
        CASE
            WHEN `Order Profit Per Order` < 0
            THEN 1 ELSE 0
        END
    ) AS Negative_Profit_Records
FROM supply_chain_python_import;





