DROP TABLE dim_credit_limit CASCADE CONSTRAINTS;
DROP TABLE dim_customers CASCADE CONSTRAINTS;
DROP TABLE dim_products CASCADE CONSTRAINTS;
DROP TABLE dim_time CASCADE CONSTRAINTS;
DROP TABLE fct_sales CASCADE CONSTRAINTS;
DROP TABLE min_pdt_dpt CASCADE CONSTRAINTS;


CREATE TABLE dim_credit_limit (
    cdt_lmt_id      NUMBER(9) NOT NULL,
    credit          NUMBER(10),
    credit_date     DATE,
    credit_limit_id NUMBER,
    person_id       NUMBER,
    prs_credit      NUMBER(5)
);

ALTER TABLE dim_credit_limit ADD CONSTRAINT dim_credit_limit_pk PRIMARY KEY ( cdt_lmt_id );

CREATE TABLE dim_customers (
    customer_id NUMBER(9) NOT NULL,
    cust_id     NUMBER(9),
    cst_name    VARCHAR2(50),
    postal_code NUMBER(10),
    gender      VARCHAR2(10),
    city        VARCHAR2(20),
    birth_date  DATE,
    email       VARCHAR2(30)
);

ALTER TABLE dim_customers ADD CONSTRAINT dim_customers_pk PRIMARY KEY ( customer_id );

CREATE TABLE dim_products (
    pdct_id                NUMBER(9) NOT NULL,
    prod_id                NUMBER(9),
    prod_desc_id           NUMBER(9),
    prod_name              VARCHAR2(50),
    prod_desc              VARCHAR2(4000),
    prod_cost              NUMBER(8),
    min_pdt_dpt_pdt_dpt_id NUMBER(9) NOT NULL,
    pdt_tax                NUMBER(2)
);

ALTER TABLE dim_products ADD CONSTRAINT dim_products_pk PRIMARY KEY ( pdct_id );

CREATE TABLE dim_time (
    date_id    NUMBER(9) NOT NULL,
    dt_quarter NUMBER(2),
    dt_year    NUMBER(4),
    dt_month   NUMBER(2),
    dt_day     NUMBER(2),
    dim_date   DATE
);

ALTER TABLE dim_time ADD CONSTRAINT dim_time_pk PRIMARY KEY ( date_id );

CREATE TABLE fct_sales (
    num_products_sold           NUMBER(4, 1),
    credit_spent                NUMBER(6, 1),
    min_pdt_dpt_pdt_dpt_id      NUMBER(9) NOT NULL,
    dim_time_date_id            NUMBER(9) NOT NULL,
    dim_customers_customer_id   NUMBER(9) NOT NULL,
    dim_credit_limit_cdt_lmt_id NUMBER(9) NOT NULL,
    dim_products_pdct_id        NUMBER(9) NOT NULL
);

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_pk PRIMARY KEY ( min_pdt_dpt_pdt_dpt_id,
                                              dim_time_date_id,
                                              dim_customers_customer_id,
                                              dim_credit_limit_cdt_lmt_id,
                                              dim_products_pdct_id );

CREATE TABLE min_pdt_dpt (
    pdt_dpt_id       NUMBER(9) NOT NULL,
    max_price        NUMBER(5),
    min_price        NUMBER(5),
    price_rank       VARCHAR2(50),
    prod_subcategory VARCHAR2(50),
    prod_category    VARCHAR2(50)
);

ALTER TABLE min_pdt_dpt ADD CONSTRAINT min_pdt_dpt_pk PRIMARY KEY ( pdt_dpt_id );

ALTER TABLE dim_products
    ADD CONSTRAINT dim_products_min_pdt_dpt_fk FOREIGN KEY ( min_pdt_dpt_pdt_dpt_id )
        REFERENCES min_pdt_dpt ( pdt_dpt_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_credit_limit_fk FOREIGN KEY ( dim_credit_limit_cdt_lmt_id )
        REFERENCES dim_credit_limit ( cdt_lmt_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_customers_fk FOREIGN KEY ( dim_customers_customer_id )
        REFERENCES dim_customers ( customer_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_products_fk FOREIGN KEY ( dim_products_pdct_id )
        REFERENCES dim_products ( pdct_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_dim_time_fk FOREIGN KEY ( dim_time_date_id )
        REFERENCES dim_time ( date_id );

ALTER TABLE fct_sales
    ADD CONSTRAINT fct_sales_min_pdt_dpt_fk FOREIGN KEY ( min_pdt_dpt_pdt_dpt_id )
        REFERENCES min_pdt_dpt ( pdt_dpt_id );
