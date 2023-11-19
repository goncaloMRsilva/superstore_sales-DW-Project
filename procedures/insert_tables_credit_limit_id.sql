create or replace procedure insert_tables_credit_limit_id is
begin
    delete credit_limit_id;
    delete person;

    insert_person_lookup;
    insert_creditLimitId_principal;
end;
