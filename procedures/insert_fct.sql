create or replace procedure insert_fct is

cursor c_fct is select sum(quantity_sold) as quantity_sold, sum(Credit) as Credit, credit_limit_id.Credit_Limit_Id, trunc(sale_date) as sale_date, products.prod_id, cust_id
from sales_rows, sales, products, credit_limit_id
where sales_rows.sale_id = sales.sale_id
and products.prod_id = sales_rows.prod_id
and sales.Credit_Limit_Id = Credit_Limit_Id.Credit_Limit_Id
and sales.Credit_Limit_Id is not null
group by trunc(sale_date), products.prod_id, cust_id, credit_limit_id.Credit_Limit_Id
order by trunc(sale_date);

cur_data c_fct%ROWTYPE;
v_prod_func dim_Products.Pdct_Id%TYPE;

begin
    open c_fct;
    loop
        fetch c_fct into cur_data;
        exit when c_fct%NOTFOUND;

        v_prod_func := get_dim_products_id(cur_data.prod_id);

        insert into fct_Sales(Num_Products_Sold, Credit_Spent, min_Pdt_Dpt_Pdt_Dpt_Id, dim_Time_Date_id, dim_Customers_Customer_Id, dim_Credit_Limit_Cdt_Lmt_Id, dim_Products_Pdct_Id)
        values(cur_data.quantity_sold, cur_data.Credit, get_min_pdt_dpt(v_prod_func),
        get_dim_time_id(cur_data.sale_date), get_dim_customers_id(cur_data.cust_id),
        get_dim_credit_limit_id(cur_data.Credit_Limit_Id),
        v_prod_func);
        
    end loop;
end;
