-- query for dim_cusomers 
-- 
SELECT  {{ dbt_utils.generate_surrogate_key(['customers.customerNumber']) }} as customer_key,
        customerName     as customer_name, 
        contactLastName  as contact_last_name, 
        contactFirstName as contact_first_name, 
        phone        as phone, 
        addressLine1 as address_line_1, 
        addressLine2 as address_line_2, 
        postalCode  as postal_code, 
        city        as city, 
        state       as state, 
        country     as country, 
        creditLimit as cred_limit
FROM cutomers;


-- query for dim_products 
--
SELECT  {{ dbt_utils.generate_surrogate_key(['products.productCode']) }}as product_key,
        productName        as product_name, 
        productLine        as product_line, 
        productVendor      as product_vendor, 
        productDescription as product_description, 
        productlines.textDescription as product_line_description
FROM products
JOIN productlines ON  productlines.productLine = products.productLine

-- query for dim_employees 
--
SELECT  {{ dbt_utils.generate_surrogate_key(['employees.employeeNumber']) }} as employee_key,
        lastName  as employee_last_name, 
        firstName as employee_first_name, 
        jobTitle  as job_title 
        email     as email
FROM employees

-- query for dim_offices 
--
SELECT  officeCode as office_code, 
        postalCode as postal_code, 
        city as city,
        state as state,
        country as country,
        territory as terrigory
FROM offices


-- query for fact_orders 
--
select  {{ dbt_utils.generate_surrogate_key(['orders.orderNumber','orderdetails.orderLineNumber']) }} as employee_key,
 {{ dbt_utils.generate_surrogate_key(['customers.customerNumber']) }}as customer_key,
 {{ dbt_utils.generate_surrogate_key(['customers.salesRepEmployeeNumber']) }}as employee_key,
 {{ dbt_utils.generate_surrogate_key(['orderdetails.productCode']) }}as product_key,
orders.orderDate as order_date,
orders.requiredDate as order_required_date, 
orders.order_shipped_date as order_shipped_date,
orderdetails.quantityOrdered as quantity_ordered, 
orderdetails.priceEach as product_price
FROM  orders 
JOIN orderdetails ON orderdetails.orderNumber=orders.orderNumber
JOIN customers ON customers.customerNumber = orders.customerNumber


===================================================================================================
^------------- my answers
v------------- answers key
===================================================================================================


NOTE: can configure global variables in dbt_project.yml.  classicmodels will be defined as a global variable 
and referenced as: 

{{var("source_schema")}}

hence:
FROM {{var("source_schema")}}.customers 

-- query for dim_cusomers 
--
 SELECT 
    {{dbt_utils.generate_surrogate_key(['customerNumber'])}} as customer_key, 
    customerName as customer_name,   
    contactLastName as customer_last_name, 
    contactFirstName as customer_first_name, 
    phone as phone, 
    addressLine1 as address_line_1, 
    addressLine2 as address_line_2, 
    postalCode as postal_code, 
    city as city, 
    state as state, 
    country as country,
    creditLimit as credit_limit
FROM classicmodels.customers


-- query for dim_products 
--
SELECT 
    {{ dbt_utils.generate_surrogate_key(['productCode']) }} as product_key, 
    productName as product_name, 
    products.productLine as product_line, 
    productScale as product_scale, 
    productVendor as product_vendor,
    productDescription as product_description, 
    textDescription as product_line_description
FROM classicmodels.products
JOIN classicmodels.productlines ON products.productLine=productlines.productLine


-- query for dim_employees 
--
SELECT
    {{ dbt_utils.generate_surrogate_key(['employeeNumber']) }} as employee_key,
    lastName as employee_last_name, 
    firstName as employee_first_name, 
    jobTitle as job_title, 
    email as email
FROM classicmodels.employees

-- query for dim_offices 
--
SELECT 
    {{ dbt_utils.generate_surrogate_key(['officeCode']) }} as office_key, 
    postalCode as postal_code, 
    city as city, 
    state as state, 
    country as country, 
    territory as territory
FROM classicmodels.offices

-- query for fact_orders 
--
SELECT 
    {{ dbt_utils.generate_surrogate_key(['orders.orderNumber', 'orderdetails.orderLineNumber']) }} as fact_order_key,
    {{ dbt_utils.generate_surrogate_key(['customers.customerNumber']) }} as customer_key, 
    {{ dbt_utils.generate_surrogate_key(['employees.employeeNumber']) }} as employee_key,
    {{ dbt_utils.generate_surrogate_key(['offices.officeCode']) }} as office_key,
    {{ dbt_utils.generate_surrogate_key(['productCode']) }} as product_key, 
    orders.orderDate as order_date,
    orders.requiredDate as order_required_date, 
    orders.shippedDate as order_shipped_date,
    orderdetails.quantityOrdered as quantity_ordered, 
    orderdetails.priceEach as product_price
FROM classicmodels.orders
JOIN classicmodels.orderdetails ON orders.orderNumber = orderdetails.orderNumber
JOIN classicmodels.customers ON orders.customerNumber = customers.customerNumber
JOIN classicmodels.employees ON customers.salesRepEmployeeNumber = employees.employeeNumber
JOIN classicmodels.offices ON employees.officeCode = offices.officeCode

