--
drop table book_fee_jrjg;
create table book_fee_jrjg (

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


drop sequence seq_fee_jrjg;
create sequence seq_fee_jrjg as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 财务费用 - 金融机构手续费 
--


comment on table  book_fee_jrjg is '财务费用 - 金融机构手续费';

comment on column book_fee_jrjg.yp_acct is '银行账户号及相应开户行';
comment on column book_fee_jrjg.period     is '会计期间';

comment on column book_fee_jrjg.j      is '借方发生额';



-- MQT
create table sum_fee_jrjg as (
    select yp_acct   as yp_acct,
	   period     as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_fee_jrjg
    group by yp_acct, period
)
data initially deferred refresh immediate
in tbs_dat;

-- integrity unchecked
set integrity for sum_fee_jrjg materialized query immediate unchecked;
