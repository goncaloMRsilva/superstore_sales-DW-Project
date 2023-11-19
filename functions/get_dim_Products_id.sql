create or replace function get_dim_Products_id(p_product_id Products.Prod_Id%TYPE)
return number is

v_dim_Product_Id dim_Products.Pdct_Id%TYPE;

begin
select Pdct_Id into v_dim_Product_Id
from dim_Products
where dim_Products.Prod_Id = p_product_id;

return v_dim_Product_Id;

end;
