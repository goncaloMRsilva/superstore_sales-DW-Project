create or replace function get_price_rank(p_price number) 
return varchar2 is

v_price_rank varchar2(50);

begin

if 0 <= p_price and  p_price <= 250 then
    v_price_rank := 'Cheap';
else if 250 <= p_price and  p_price <= 700 then
    v_price_rank := 'Medium price';
else 
    v_price_rank := 'Expensive';
end if;
end if;

return v_price_rank;
end;
