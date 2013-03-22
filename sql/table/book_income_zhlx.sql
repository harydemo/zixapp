--
drop table book_income_zhlx;
create table book_income_zhlx (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    yp_acct  integer      not null,
    -- dimension (tp)
    period      date         not null,
    
    -- jz data
    j       bigint default 0 not null,
    d       bigint default 0 not null,

    -- jzpz 
    ys_type     char(4)      not null,
    ys_id       bigint       not null,
    jzpz_id     bigint       not null,

    
    -- misc
    --rec_c_ts    timestamp default current timestamp
    ts_c        timestamp default current timestamp

) in tbs_dat index in tbs_idx;


drop sequence seq_income_zhlx;
create sequence seq_income_zhlx as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 财务费用 - 账户利息收入 
--


comment on table  book_income_zhlx is '财务费用 - 账户利息收入';

comment on column book_income_zhlx.yp_acct is '银行账户号及相应开户行';
comment on column book_income_zhlx.period     is '会计期间';

comment on column book_income_zhlx.j      is '借方发生额';



-- MQT
create table sum_income_zhlx as (
    select yp_acct    as yp_acct,
	   period     as period,
   	   sum(j)     as j,
	   sum(d)     as d,
	   count(*)   as cnt
    from book_income_zhlx
    group by yp_acct, period
)
data initially deferred refresh immediate
in tbs_dat;

-- integrity unchecked
set integrity for sum_income_zhlx materialized query immediate unchecked;
