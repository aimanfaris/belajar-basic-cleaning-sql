select *
from dirty_customers dc 

create table clean_customers as
select distinct on (id) *
from dirty_customers 
order by id

update clean_customers 
set full_name = trim(full_name)
where full_name is not null

update clean_customers
set email = lower(email)
where email is not null

update clean_customers
set city = initcap(city)
where city is not null

delete from clean_customers 
where full_name is null or trim(full_name) = ''

delete from clean_customers 
where email is null or trim(email) = ''

delete from clean_customers
where city is null or trim(city) = ''

delete from clean_customers
where age is null

select * 
from clean_customers
order by id

select full_name, city
from clean_customers 
where city = 'Chicago'


drop table clean_customers
