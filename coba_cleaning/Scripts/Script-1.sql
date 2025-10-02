select * from csorders c 

create table cleans as
select *
from csorders 
order by order_id

update cleans
set customer_name = initcap(customer_name)
where customer_name is not null

update cleans 
set order_status = initcap(order_status)
where order_status is not null

alter table cleans
alter column order_date type date
using case 
    when order_date ~ '^\d{4}-\d{2}-\d{2}$' then to_date(order_date, 'yyyy-mm-dd')
    when order_date ~ '^\d{2}/\d{2}/\d{4}$' then to_date(order_date, 'mm/dd/yyyy')
    when order_date ~ '^\d{4}/\d{2}/\d{2}$' then to_date(order_date, 'yyyy/mm/dd')
    else null
end;

update cleans c
set price = replace(price :: text, '$', '')
where price is not null

update cleans 
set country = initcap(country)
where country is not null

update cleans
set country = case 
    when lower(country) in ('usa', 'us') then 'USA'
    when lower(country) in ('uk') then 'UK'
    else initcap(country)
end;

update cleans
set quantity = case 
    when lower(quantity) = 'two' then '2'
    else quantity
end;

alter table cleans 
alter column order_id type int using order_id :: int


select *
from cleans

drop table cleans

