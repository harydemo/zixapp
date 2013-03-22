--
drop table book_cost_bfee;
create table book_cost_bfee (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    c        integer     not null,
    p        integer     not null,
    bi       integer     not null,
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


drop sequence seq_cost_bfee;
create sequence seq_cost_bfee as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 成本 - 银行手续费支出 
--


comment on table  book_cost_bfee is '成本 - 银行手续费支出';
comment on column book_cost_bfee.id         is '主键';
comment on column book_cost_bfee.c       is '客户编号';
comment on column book_cost_bfee.p       is '产品类型';
comment on column book_cost_bfee.bi      is '银行接口编号';
comment on column book_cost_bfee.period     is '会计期间';
comment on column book_cost_bfee.j      is '借方发生额';




-- MQT
create table sum_cost_bfee as (
    select c        as c,
	   p        as p,
    	   bi	    as bi,
	   period     as period,
	   sum(j)   as j,
	   sum(d)   as d,
	   count(*) as cnt
    from book_cost_bfee
    group by c, p, bi, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_cost_bfee materialized query immediate unchecked;
