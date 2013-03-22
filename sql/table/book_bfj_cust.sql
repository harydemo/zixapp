--
drop table book_bfj_cust;
create table book_bfj_cust (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    c        integer            not null,
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


drop sequence seq_bfj_cust;
create sequence seq_bfj_cust as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 客户备付金 - 备付金
--


comment on table  book_bfj_cust is '客户备付金 - 备付金';
comment on column book_bfj_cust.id         is '主键';
comment on column book_bfj_cust.c       is '客户编号';
comment on column book_bfj_cust.period       is '会计期间';
comment on column book_bfj_cust.j      is '借方发生额';




-- MQT
create table sum_bfj_cust as (
    select c        as c,
	   period     as period,
	   sum(j)   as j,
           sum(d)   as d,
	   count(*) as cnt
    from book_bfj_cust
    group by c, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_bfj_cust materialized query immediate unchecked;
