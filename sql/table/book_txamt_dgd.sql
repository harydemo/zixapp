--
drop table book_txamt_dgd;
create table book_txamt_dgd (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    yp_acct  integer  not null,
    bi       integer  not null,
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


drop sequence seq_txamt_dgd;
create sequence seq_txamt_dgd as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应收银行 - 待勾兑应收交易款 
--


comment on table  book_txamt_dgd is '应收银行 - 待勾兑应收交易款';
comment on column book_txamt_dgd.id            is '主键';
comment on column book_txamt_dgd.yp_acct    is '银行账户号及相应开户行';
comment on column book_txamt_dgd.bi         is '银行接口编号';
comment on column book_txamt_dgd.tx_date       is '交易日期';
comment on column book_txamt_dgd.period     is '会计期间';
comment on column book_txamt_dgd.j         is '借方发生额';




-- MQT
create table sum_txamt_dgd as (
    select yp_acct   as yp_acct,
	   bi	     as bi,
	   tx_date   as tx_date,
	   period     as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_txamt_dgd
    group by yp_acct, bi, tx_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_txamt_dgd materialized query immediate unchecked;
