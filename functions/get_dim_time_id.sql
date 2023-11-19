create or replace function get_dim_time_id(p_date date)
return number is

v_dim_time_id dim_time.Date_Id%TYPE;

begin

select Date_Id into v_dim_time_id
from dim_Time
where dim_time.dim_Date = trunc(p_date);

return v_dim_time_id;
end;
