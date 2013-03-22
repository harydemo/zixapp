--
drop table book_txamt_yhyf;
create table book_txamt_yhyf (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    yp_acct     integer      not null,
    zjbd_type   integer      not null,
    zjbd_date      date         not null,
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


drop sequence seq_txamt_yhyf;
create sequence seq_txamt_yhyf as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应付银行 - 已核应付交易款 
--


comment on table  book_txamt_yhyf is '应付银行 - 已核应付交易款';
comment on column book_txamt_yhyf.id             is '主键';
comment on column book_txamt_yhyf.yp_acct     is '银行账户号及相应开户行';
comment on column book_txamt_yhyf.zjbd_type   is '资金变动类型';
comment on column book_txamt_yhyf.zjbd_date      is '银行出入账日期';
comment on column book_txamt_yhyf.period     is '会计期间';
comment on column book_txamt_yhyf.j      is '借方发生额';




-- MQT
create table sum_txamt_yhyf as (
    select yp_acct    as yp_acct,
	   zjbd_type  as zjbd_type,
       	   zjbd_date  as zjbd_date,
	   period     as period,
	   sum(j)     as j,
	   sum(d)     as d,
	   count(*)   as cnt
    from book_txamt_yhyf
    group by yp_acct, zjbd_type, zjbd_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_txamt_yhyf materialized query immediate unchecked;
