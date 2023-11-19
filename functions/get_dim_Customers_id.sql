create or replace function get_dim_Customers_id(p_customers_id Customers.Cust_Id%TYPE)
return number is

v_dim_Customers_Id dim_Customers.Customer_Id%TYPE;

begin
select Customer_Id into v_dim_Customers_Id
from dim_Customers
where dim_Customers.Cust_Id = p_customers_id;

return v_dim_Customers_Id;

end;
