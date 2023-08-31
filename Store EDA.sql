USE store;

select * from sales;

/* What is the total number of orders */
select sum(Quantity_Ordered) as totat_orders from sales;

/* What is the total sales Revenue */
select sum(Sales*Quantity_Ordered) as TotalSalesRevenue from sales;

/* What is the Average Quantity Ordered*/
select avg(Quantity_Ordered) as Averagequantity from sales;

/* What is the distribution of orders over time daily */
/*daily*/
select date(str_to_date(Order_Date, '%d-%m-%y')) as OrderDay, count(*) as DailyOrderCount
from sales
where Order_Date is not null and str_to_date(Order_Date, '%d-%m-%y') is not null 
group by OrderDay
order by OrderDay;

/* Which city has the highest number of orders? */
select City, count(*) as OrderCount
from sales
group by City
order by OrderCount
limit 1; 

/* Which city generates the most revenue?*/
select city, sum(Revenue) as TotalRevenue 
from( select city, sum(Quantity_Ordered * Price_Each) as Revenue 
		from sales
        group by City, Order_Date
	) as subquery
group by City
order by TotalRevenue
limit 1;

/* Which product is the best-seller in terms of quantity? */
select Product 
from (
	select Product, sum(Quantity_Ordered) as TotalQuantity
    from sales
    group by Product
    )
as subquery
order by TotalQuantity desc
limit 1;

/* Which product generates the most revenue?*/
select Product 
from(
	select product, sum(Quantity_Ordered * Price_Each) as TotalRevenue
    from sales
    group by Product
    )
    as subquery
    order by TotalRevenue
    limit 1;
	
/* Which purchasing address has the highest sales? */
select Purchase_Address 
from (
	select Purchase_Address, sum(Quantity_Ordered * Price_Each) as TotalSales
    from sales
    group by Purchase_Address
    )
    as subquery
    order by TotalSales
    limit 1;

/* Are there any hourly trends in sales?*/
select Hour, sum(Quantity_Ordered * Price_Each) as TotalSales 
from sales
group by Hour
order by Hour; 

/* What are the peak hours for order placement?*/
select Hour, count(*) as OrderCount
from sales
group by Hour 
order by OrderCount
limit 1; 








