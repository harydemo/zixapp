--
drop table book_bsc_zyzj;
create table book_bsc_zyzj (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    yp_acct  integer      not null,
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


drop sequence seq_bsc_zyzj;
create sequence seq_bsc_zyzj as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应收账款 - 银行 - 银行短款 
--


comment on table  book_bsc_zyzj is '应收账款 - 银行 - 银行短款';
comment on column book_bsc_zyzj.id         is '主键';
comment on column book_bsc_zyzj.yp_acct is '银行账户号及相应开户行';
comment on column book_bsc_zyzj.e_date is '差错日期';
comment on column book_bsc_zyzj.period     is '会计期间';
comment on column book_bsc_zyzj.j      is '借方发生额';




-- MQT
create table sum_bsc_zyzj as (
    select yp_acct   as yp_acct,
	   e_date    as e_date,
	   period     as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_bsc_zyzj
    group by yp_acct, e_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_bsc_zyzj materialized query immediate unchecked;
