--
drop table book_cfee_dqhf;
create table book_cfee_dqhf (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    c        integer      not null,
    p        integer      not null,
    tx_date     date         not null,
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


drop sequence seq_cfee_dqhf;
create sequence seq_cfee_dqhf as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 应收账款 - 客户 - 定期划付客户手续费 
--


comment on table  book_cfee_dqhf is '应收账款 - 客户 - 定期划付客户手续费';
comment on column book_cfee_dqhf.id         is '主键';
comment on column book_cfee_dqhf.c       is '客户编号';
comment on column book_cfee_dqhf.p       is '产品类型';
comment on column book_cfee_dqhf.tx_date    is '交易日期';
comment on column book_cfee_dqhf.period     is '会计期间';
comment on column book_cfee_dqhf.j      is '借方发生额';




-- MQT
create table sum_cfee_dqhf as (
    select c         as c,
	   p         as p,
	   tx_date   as tx_date,
	   period     as period,
	   sum(j)    as j,
	   sum(d)    as d,
	   count(*)  as cnt
    from book_cfee_dqhf
    group by c, p, tx_date, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_cfee_dqhf materialized query immediate unchecked;
