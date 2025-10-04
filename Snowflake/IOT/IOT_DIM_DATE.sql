USE DATABASE IOT_DB;
USE SCHEMA DWH;


-- insert_dim_date.sql
insert into DIM_DATE (
    DATE_SR_KEY,
    FULL_DATE,
    DAY,
    DAY_NAME,
    DAY_OF_WEEK,
    WEEK,
    WEEKDAY_FLAG,
    MONTH,
    MONTH_NAME,
    QUARTER,
    YEAR,
    IS_WEEKEND,
    HOLIDAY_FLAG
)
with date_spine as (
    select 
        dateadd(day, row_number() over(order by seq4()) - 1, dateadd(year, -10, current_date)) as full_date
    from table(generator(rowcount => 2000))  -- ~2000 days, adjust if needed
)
select
    to_number(to_char(full_date,'YYYYMMDD')) as DATE_SR_KEY,
    full_date as FULL_DATE,
    extract(day from full_date) as DAY,
    to_char(full_date,'DAY') as DAY_NAME,
    extract(dow from full_date) as DAY_OF_WEEK,
    extract(week from full_date) as WEEK,
    case when extract(dow from full_date) in (0,6) then false else true end as WEEKDAY_FLAG,
    extract(month from full_date) as MONTH,
    to_char(full_date,'MONTH') as MONTH_NAME,
    extract(quarter from full_date) as QUARTER,
    extract(year from full_date) as YEAR,
    case when extract(dow from full_date) in (0,6) then true else false end as IS_WEEKEND,
    false as HOLIDAY_FLAG   -- placeholder, you can update with holiday calendar
from date_spine;


SELECT COUNT(*)
FROM DIM_DATE; 


insert into IOT_DB.DWH.DIM_DATE (DATE_SR_KEY, full_date)
select -1, to_date('1900-01-01')

