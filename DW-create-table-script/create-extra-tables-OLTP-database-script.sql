CREATE TABLE person (
    person_id NUMBER(9) NOT NULL,
    credit    NUMBER
);

ALTER TABLE person ADD CONSTRAINT person_pk PRIMARY KEY ( person_id );

CREATE TABLE credit_limit_id (
    credit_limit_id  NUMBER NOT NULL,
    credit           NUMBER(9),
    credit_date      DATE,
    owner            VARCHAR2(10),
    person_person_id NUMBER(9) NOT NULL
);

ALTER TABLE credit_limit_id ADD CONSTRAINT credit_limit_id_pk PRIMARY KEY ( credit_limit_id );

ALTER TABLE credit_limit_id
    ADD CONSTRAINT credit_limit_id_person_fk FOREIGN KEY ( person_person_id )
        REFERENCES person ( person_id );

