create table smoothies.public.orders(
    INGREDIENTS varchar(200)
);

insert into smoothies.public.orders(ingredients)
values ('Cantaloupe Guava Jackfruit Elderberries Figs');

select * from smoothies.public.orders;

truncate table  smoothies.public.orders;


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
SELECT 'DABW002' as step
 ,(select IFF(count(*)>=5,5,0)
    from (select ingredients from smoothies.public.orders
    group by ingredients)
 ) as actual
 ,  5 as expected
 ,'At least 5 different orders entered' as description
);

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW003' as step
 ,(select ascii(fruit_name) from smoothies.public.fruit_options
where fruit_name ilike 'z%') as actual
 , 90 as expected
 ,'A mystery check for the inquisitive' as description
);

alter table SMOOTHIES.PUBLIC.ORDERS add column name_on_order varchar(100);

insert into smoothies.public.orders(ingredients, name_on_order) values ('Dragon Fruit Blueberries Figs Elderberries Kiwi ','dhruvi');

select * from smoothies.public.orders where name_on_order is not null;

ALTER TABLE ORDERS
ADD COLUMN ORDER_FILLED BOOLEAN DEFAULT FALSE;


 update smoothies.public.orders
       set order_filled = true
       where name_on_order is null;


select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
  SELECT 'DABW004' as step
 ,( select count(*) from smoothies.information_schema.columns
    where table_schema = 'PUBLIC' 
    and table_name = 'ORDERS'
    and column_name = 'ORDER_FILLED'
    and column_default = 'FALSE'
    and data_type = 'BOOLEAN') as actual
 , 1 as expected
 ,'Order Filled is Boolean' as description
);

truncate table smoothies.public.orders;

alter table SMOOTHIES.PUBLIC.ORDERS 
add column order_uid integer --adds the column
default smoothies.public.order_seq.nextval  --sets the value of the column to sequence
constraint order_uid unique enforced; --makes sure there is always a unique value in the column

select * from SMOOTHIES.PUBLIC.ORDERS ;

create or replace table smoothies.public.orders (
       order_uid integer default smoothies.public.order_seq.nextval,
       order_filled boolean default false,
       name_on_order varchar(100),
       ingredients varchar(200),
       constraint order_uid unique (order_uid),
       order_ts timestamp_ltz default current_timestamp()
);

select GRADER(step, (actual = expected), actual, expected, description) as graded_results from (
 SELECT 'DABW005' as step
 ,(select count(*) from SMOOTHIES.INFORMATION_SCHEMA.STAGES
where stage_name like '%(Stage)') as actual
 , 2 as expected
 ,'There seem to be 2 SiS Apps' as description
);

delete from SMOOTHIES.PUBLIC.ORDERS where name_on_order <> 'Kevin' and name_on_order <> 'Divya' and name_on_order <> 'Xi';

select * from orders;
select * from orders where name_on_order = 'Xi ';
delete from orders where name_on_order = 'Xi ';
