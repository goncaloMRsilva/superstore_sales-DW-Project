create or replace procedure insert_dim_data(p_start_year number, p_end_year number) is
v_init_date number(9);
v_end_date number(9);
v_last_year number(4);
begin
 v_init_date := to_number(to_char(to_date('1/1/'||p_start_year,'dd/mm/yyyy'),'j'));
 v_end_date := to_number(to_char(to_date('31/12/'||p_end_year,'dd/mm/yyyy'),'j')); 
select count(Date_id) into v_last_year from dim_Time;
if(v_last_year) > 0 then
    select max(dt_year) into v_last_year from dim_Time;
end if;
 loop
    if to_number(to_char(to_date(v_init_date,'j'), 'yyyy')) > v_last_year then
        insert into dim_Time(Date_id, dt_Quarter, dt_Year, dt_Month, dt_Day, dim_date)
        values(v_init_date, to_number(to_char(to_date(v_init_date, 'j'),'q')), to_number(to_char(to_date(v_init_date,'j'),'yyyy')), to_number(to_char(to_date(v_init_date,'j'),'mm')), to_number(to_char(to_date(v_init_date,'j'),'dd')), to_date(v_init_date,'j')); 
    end if;
    exit when v_init_date = v_end_date;
    v_init_date := v_init_date + 1;
 end loop;
end;
