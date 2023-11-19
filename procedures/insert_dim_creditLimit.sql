create or replace procedure insert_dim_creditLimit is

begin
insert into dim_Credit_Limit(Cdt_Lmt_Id, Credit, Credit_date, Owned_by, Credit_Limit_Id, Person_Id,Prs_Credit)
select seq_pk.nextval, Credit_Limit_Id.Credit, Credit_Limit_Id.Credit_date, Credit_Limit_Id.owner, Credit_Limit_Id.Credit_Limit_Id, Person.Person_Id, Person.Credit
from Credit_Limit_Id, Person
where Credit_Limit_Id.Person_Person_Id = Person.Person_Id
and CREDIT_LIMIT_ID not in (
select CREDIT_LIMIT_ID
from dim_Credit_Limit
);
end;
