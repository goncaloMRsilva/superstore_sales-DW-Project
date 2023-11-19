create or replace procedure insert_dim_Customers is

begin
insert into dim_Customers(Customer_Id, Cust_Id, Cst_Name, Postal_Code, Gender, City, Birth_Date, Email)
select seq_dim_customers.nextval, CUST_ID, CUST_FIRST_NAME, CUST_POSTAL_CODE, CUST_GENDER, CUST_CITY, CUST_BIRTH_DATE, CUST_EMAIL
from CUSTOMERS
where (CUST_ID, CUST_FIRST_NAME, CUST_POSTAL_CODE, CUST_GENDER, CUST_CITY, CUST_BIRTH_DATE, CUST_EMAIL)
not in (select Cust_Id, Cst_Name, Postal_Code, Gender, City, Birth_Date, Email from dim_Customers);
end;
