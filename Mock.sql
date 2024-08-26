Problem 1: Top Travellers

# Write your MySQL query statement below
select u.name, ifnull(sum(r.distance),0) as travelled_distance from
Users u left join Rides r on u.id = r.user_id
group by u.id
order by travelled_distance desc, u.name asc;

Problem 2: Apples & Oranges

# Write your MySQL query statement below
select sale_date, sum(case
                            when fruit = 'apples' then sold_num
                            when fruit = 'oranges' then -sold_num
                        end) as diff
                from Sales
                group by sale_date
                order by sale_date

Problem 3: Customers Who Bought All Products

# Write your MySQL query statement below
select c.customer_id from Customer c 
group by c.customer_id
having count(distinct c.product_key) = (select count(*) from Product)

Problem 4: Product Sales Analysis III

# Write your MySQL query statement below
WITH cte AS (
    SELECT product_id, year AS first_year, quantity, price,
           RANK() OVER (PARTITION BY product_id ORDER BY year) AS rnk
    FROM Sales
)
SELECT product_id, first_year, quantity, price
FROM cte
WHERE rnk = 1;

Problem 5: Market Analysis II

# Write your MySQL query statement below
 with cte1 as (
    select seller_id as user_id, item_id from (select seller_id, item_id, row_number() over(partition by seller_id order by order_date) as rnk
    from Orders) as tmp
    where rnk = 2 ), 
cte2 as (select u.user_id, i.item_id from Users u inner join Items i on u.favorite_brand = i.item_brand
order by u.user_id),
cte3 as (select c1.user_id from cte1 c1 inner join cte2 c2 on c1.item_id = c2.item_id and c1.user_id = c2.user_id)

select user_id as seller_id, case
                            when user_id in (select * from cte3) then 'yes'
                            when user_id not in (select * from cte3) then 'no'
                            end as 2nd_item_fav_brand
from Users

Problem 6: Tournament Winners

