create or replace procedure insert_person_lookup is

begin
    insert into PERSON(PERSON_ID,CREDIT) values(123456,3000);
    insert into PERSON(PERSON_ID,CREDIT) values(234567,1500);
    insert into PERSON(PERSON_ID,CREDIT) values(345678,1000);
    insert into PERSON(PERSON_ID,CREDIT) values(456789,2000);
    insert into PERSON(PERSON_ID,CREDIT) values(654321,2500);
    insert into PERSON(PERSON_ID,CREDIT) values(765432,5000);
end;
