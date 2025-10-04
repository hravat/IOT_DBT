USE DATABASE IOT_DB;
USE SCHEMA DWH;

-- insert_dim_time.sql
-- insert_dim_time.sql
insert into DIM_TIME (
    TIME_SR_KEY,
    FULL_TIME,
    HOUR,
    MINUTE,
    SECOND,
    AM_PM,
    HOUR_OF_DAY
)
with time_spine as (
    select 
        row_number() over(order by seq4()) - 1 as seconds_since_midnight
    from table(generator(rowcount => 86400))  -- 24*60*60 = 86,400 rows
)
select
    to_number(to_char(
        dateadd(second, seconds_since_midnight, '00:00:00'::time), 
        'HH24MISS'
    )) as TIME_SR_KEY,  -- e.g. 093015
    dateadd(second, seconds_since_midnight, '00:00:00'::time) as FULL_TIME,
    extract(hour   from dateadd(second, seconds_since_midnight, '00:00:00'::time)) as HOUR,
    extract(minute from dateadd(second, seconds_since_midnight, '00:00:00'::time)) as MINUTE,
    extract(second from dateadd(second, seconds_since_midnight, '00:00:00'::time)) as SECOND,
    case 
        when extract(hour from dateadd(second, seconds_since_midnight, '00:00:00'::time)) < 12 
        then 'AM' 
        else 'PM' 
    end as AM_PM,
    extract(hour from dateadd(second, seconds_since_midnight, '00:00:00'::time)) as HOUR_OF_DAY
from time_spine;



SELECT *
FROM DIM_TIME; 

insert into IOT_DB.DWH.DIM_TIME (TIME_SR_KEY, FULL_TIME)
select -1, NULL

