create or replace procedure insert_mdim_Pdt_Dpt is

cursor c_mdim is
select Prod_subcategory, Prod_category, Prod_list_price
from sub_categories, categories, products
where (Prod_subcategory, Prod_category, Prod_list_price) not in (select Prod_subcategory, Prod_category, Prod_list_price from min_Pdt_Dpt)
and Sub_categories.Cat_id = Categories.Cat_id 
and Products.sub_cat_id = sub_categories.sub_cat_id;

v_cur_data c_mdim%ROWTYPE;
v_max_price min_Pdt_Dpt.max_price%TYPE;
v_min_price min_Pdt_Dpt.min_price%TYPE;
v_price_rank min_Pdt_Dpt.price_rank%TYPE;
v_controlo number;

begin
open c_mdim;
loop
    fetch c_mdim into v_cur_data;
    exit when c_mdim%NOTFOUND;

    v_price_rank := get_price_rank(v_cur_data.PROD_LIST_PRICE);

    if v_price_rank = 'Cheap' then
        v_min_price := 0;
        v_max_price := 250;
    else if v_price_rank = 'Medium price' then
        v_min_price := 250;
        v_max_price := 700;
    else if v_price_rank = 'Expensive' then
        v_min_price := 700;
        v_max_price := 1200;
    end if;
    end if;
    end if;

    select count(*) into v_controlo
    from min_Pdt_Dpt
    where Prod_Category = v_cur_data.Prod_category 
    and Prod_subcategory = v_cur_data.Prod_subcategory
    and Price_rank =  v_price_rank;
    if v_controlo = 0 then
        insert into min_Pdt_Dpt(Pdt_Dpt_Id,Prod_subcategory,Prod_category, Max_Price, Min_Price, Price_rank) 
        values(seq_mdim_pdt_dcp.NEXTVAL, v_cur_data.Prod_subcategory, v_cur_data.Prod_category, v_max_price, v_min_price, v_price_rank);
    end if;

end loop;
close c_mdim;
end;
