create or replace function get_min_Pdt_Dpt(p_product_id dim_Products.Pdct_Id%TYPE)
return number is

v_min_Pdt_Dpt_Fk min_Pdt_Dpt.Pdt_Dpt_Id%TYPE;

begin
select min_Pdt_Dpt_Pdt_Dpt_Id into v_min_Pdt_Dpt_Fk
from dim_products
where dim_Products.Pdct_Id = p_product_id;

return v_min_Pdt_Dpt_Fk;

end;
