--
drop table book_txamt_dqr;
create table book_txamt_dqr (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    c        integer  not null,
    tx_date     date     not null,
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


drop sequence seq_txamt_dqr;
create sequence seq_txamt_dqr as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 其他应付款 - 待确认交易款 
--


comment on table  book_txamt_dqr is '其他应付款 - 待确认交易款';
comment on column book_txamt_dqr.id        is '主键';
comment on column book_txamt_dqr.c      is '客户编号';
comment on column book_txamt_dqr.tx_date   is '交易日期';
comment on column book_txamt_dqr.period     is '会计期间';
comment on column book_txamt_dqr.j is '借方发生额';




-- MQT
create table sum_txamt_dqr as (
    select c        as c,
	   tx_date  as tx_date,
	   period     as period,
	   sum(j)   as j,
	   sum(d)   as d,
	   count(*) as cnt
    from book_txamt_dqr
    group by c, tx_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_txamt_dqr materialized query immediate unchecked;
