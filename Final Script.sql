use olist_store_analysis;

# 1 - KPI
#Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics  

SELECT
    CASE WHEN DAYOFWEEK(STR_TO_DATE(o.order_purchase_timestamp, '%Y-%m-%d')) 
    IN (1, 7) THEN 'Weekend' ELSE 'Weekday' END AS DayType,
    COUNT(DISTINCT o.order_id) AS TotalOrders,
    round(SUM(p.payment_value)) AS TotalPayments,
    round(AVG(p.payment_value)) AS AveragePayment
FROM
    orders_dataset o
JOIN
    payments_dataset p ON o.order_id = p.order_id
GROUP BY
    DayType;
    


#2nd--KPI
#Number of Orders with a review score of 5 and payment type as a credit card.

SELECT
    COUNT(DISTINCT p.Order_id) AS NumberOfOrders
FROM
    payments_dataset p
JOIN
    reviews_dataset r ON p.Order_id = r.Order_id
WHERE
    r.Review_score = 5
    AND p.Payment_type = 'credit_card';
    
    

#3rd--KPI
#The average number of days taken for order_delivered_customer_date for pet_shop

SELECT
       Product_Category_name,
    round(AVG(DATEDIFF(Order_Delivered_Customer_Date, Order_Purchase_Timestamp))) AS avg_delivery_time
FROM
    orders_dataset o
JOIN
    items_dataset i ON i.order_id = o.order_id
JOIN 
     products_dataset p ON p.product_id=i.product_id
WHERE
    p.Product_Category_name = 'pet_shop'
    AND o.Order_Delivered_Customer_Date IS NOT NULL;


#4th---KPI 
#Average price and payment values from customers of Sao Paulo City

SELECT
    round(AVG(i.Price)) AS average_price,
    round(AVG(p.Payment_value)) AS average_payment
FROM
    customers_dataset c
JOIN
    orders_dataset o ON c.Customer_id = o.Customer_id
JOIN
    items_dataset i ON o.Order_id = i.Order_id
JOIN
    payments_dataset p ON o.Order_id = p.Order_id
WHERE
    c.City = 'Sao Paulo';



#5th---KPI
#Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores

SELECT
    round(AVG(DATEDIFF(Order_Delivered_Customer_Date, Order_Purchase_Timestamp)),0) AS AvgShippingDays,
    Review_score
FROM
    orders_dataset o
JOIN
    reviews_dataset r ON o.Order_id = r.Order_id
WHERE
    Order_Delivered_Customer_Date IS NOT NULL
    AND Order_Purchase_Timestamp IS NOT NULL
GROUP BY
    Review_score;

    