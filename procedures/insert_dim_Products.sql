create or replace procedure insert_dim_Products is

cursor c_dim_products is
select Prod_Id, Prod_Desc_Id, Prod_Name, Prod_Desc, Prod_Cost, Tax_Pct
from Products, Product_Descriptions
where Prod_Desc_Id = Prod_Descriptions_Id
and (Products.Prod_Id, Product_Descriptions.Prod_Desc_Id)
not in (select Prod_Id, Prod_Desc_Id from dim_Products);

v_cur_data c_dim_products%ROWTYPE;
v_outtrigger dim_Products.min_Pdt_Dpt_Pdt_Dpt_Id%TYPE;

begin
    open c_dim_products;

    loop
        fetch c_dim_products into v_cur_data;
        exit when c_dim_products%NOTFOUND;

        v_outtrigger := getouttrigger(v_cur_data.Prod_Id);

        insert into dim_products(Pdct_Id, Prod_Id, Prod_Desc_Id, Prod_Name, Prod_Desc, Prod_Cost, min_Pdt_Dpt_Pdt_Dpt_Id, Pdt_Tax)
        values(seq_dim_products.nextval, v_cur_data.Prod_Id, v_cur_data.Prod_Desc_Id, v_cur_data.Prod_Name, v_cur_data.Prod_Desc, v_cur_data.Prod_Cost, v_outtrigger, v_cur_data.Tax_Pct);
    end loop;

    close c_dim_products;
end;
