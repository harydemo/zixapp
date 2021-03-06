--
drop table book_bfee_yhys;
create table book_bfee_yhys (

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


drop sequence seq_bfee_yhys;
create sequence seq_bfee_yhys as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应收银行 - 已核应收银行手续费 
--


comment on table  book_bfee_yhys is '应收银行 - 已核应收银行手续费';
comment on column book_bfee_yhys.id            is '主键';
comment on column book_bfee_yhys.yp_acct    is '银行账户号及相应开户行';
comment on column book_bfee_yhys.zjbd_type  is '资金变动类型';
comment on column book_bfee_yhys.zjbd_date     is '银行出入账日期';
comment on column book_bfee_yhys.period        is '会计期间';
comment on column book_bfee_yhys.j             is '借方发生额';




-- MQT
create table sum_bfee_yhys as (
    select yp_acct   as yp_acct,
   	   zjbd_type as zjbd_type,
	   zjbd_date as zjbd_date,
    	   period    as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_bfee_yhys
    group by yp_acct, zjbd_type, zjbd_date, period
)
data initially deferred refresh immediate;


-- integrity unchecked
set integrity for sum_bfee_yhys materialized query immediate unchecked;
