create or replace function getOutTrigger(p_prod_id number) 
return number is

v_outtrigger number;
v_prod_subcategory sub_categories.prod_subcategory%TYPE;
v_prod_category categories.prod_category%TYPE;
v_prod_list_price products.prod_list_price%TYPE;
v_price_rank min_Pdt_Dpt.price_rank%TYPE;

begin

select prod_subcategory, prod_category, prod_list_price
into v_prod_subcategory, v_prod_category, v_prod_list_price
from sub_categories, categories, products
where sub_categories.sub_cat_id = products.sub_cat_id
and categories.cat_id = sub_categories.cat_id
and products.prod_id = p_prod_id;

v_price_rank := get_price_rank(v_prod_list_price);

select Pdt_Dpt_Id 
into v_outtrigger
from min_Pdt_Dpt
where v_prod_subcategory = prod_subcategory
and v_prod_category = prod_category
and v_price_rank = price_rank;

return v_outtrigger; 
end;
