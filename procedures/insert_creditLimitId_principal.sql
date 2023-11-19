create or replace procedure insert_creditLimitId_principal as

cursor cur_credit_limit_id is
select distinct credit_limit_id
from sales
where credit_limit_id is not null
order by credit_limit_id;

v_credit_limit_id sales.credit_limit_id%TYPE;
v_credit_date credit_limit_id.credit_date%TYPE;
v_credit credit_limit_id.credit%TYPE;
v_owner credit_limit_id.owner%TYPE;
v_person_id credit_limit_id.person_person_id%TYPE;

v_valor number(6);
v_valor_gerado number(6);

begin
    open cur_credit_limit_id;
    loop
        fetch cur_credit_limit_id into v_credit_limit_id;
        exit when cur_credit_limit_id%NOTFOUND;

        select count(*)
        into v_valor
        from person;

        select trunc(dbms_random.value(0, v_valor))
        into v_valor_gerado
        from dual;

        select person.person_id into v_person_id
        from person
        offset v_valor_gerado rows
        fetch first 1 row only;

        v_credit_date := to_date(trunc(dbms_random.value(to_char(to_date('1/1/1980','dd/mm/yyyy'),'j'),to_char(CURRENT_DATE+1,'j'))),'j');
        v_owner := dbms_random.string('a', dbms_random.value(2,10));
        v_credit := trunc(dbms_random.value(1,10));
        insert into credit_limit_id values(v_credit_limit_id, v_credit, v_credit_date, v_owner, v_person_id);

    end loop;
    close cur_credit_limit_id;
end;
