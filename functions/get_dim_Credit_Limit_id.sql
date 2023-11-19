create or replace function get_dim_Credit_Limit_id(p_credit_limit_id Credit_Limit_Id.Credit_Limit_Id%TYPE)
return number is

v_dim_Credit_Limit_Id dim_Credit_Limit.Cdt_Lmt_Id%TYPE;

begin
select Cdt_Lmt_Id into v_dim_Credit_Limit_Id
from dim_Credit_Limit
where dim_Credit_Limit.Credit_Limit_Id = p_credit_limit_id;

return v_dim_Credit_Limit_Id;

end;
