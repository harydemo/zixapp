--
drop table book_bsc;
create table book_bsc (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    yp_acct  integer      not null,
    bi       integer      not null,
    e_date  date         not null,
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


drop sequence seq_bsc;
create sequence seq_bsc as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应收账款 - 银行 - 银行短款 
--


comment on table  book_bsc is '应收账款 - 银行 - 银行短款';
comment on column book_bsc.id         is 'id';
comment on column book_bsc.yp_acct is '银行账户号及相应开户行';
comment on column book_bsc.bi      is '银行接口编号';
comment on column book_bsc.e_date is '差错日期';
comment on column book_bsc.period     is '会计期间';
comment on column book_bsc.j      is '借方发生额';




-- MQT
create table sum_bsc as (
    select yp_acct   as yp_acct,
	   bi        as bi,
	   e_date    as e_date,
	   period     as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_bsc
    group by yp_acct, bi, e_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_bsc materialized query immediate unchecked;
