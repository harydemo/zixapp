--
drop table book_wlzj_yszy;
create table book_wlzj_yszy (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
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


drop sequence seq_wlzj_yszy;
create sequence seq_wlzj_yszy as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 往来 - 应收自有 
--


comment on table  book_wlzj_yszy is '往来 - 应收自有';
comment on column book_wlzj_yszy.id         is '主键';
comment on column book_wlzj_yszy.period     is '会计期间';
comment on column book_wlzj_yszy.j      is '借方发生额';




-- MQT
create table sum_wlzj_yszy as (
    select period     as period,
   	   sum(j)      as j,
	   sum(d)      as d,
	   count(*)    as cnt
    from book_wlzj_yszy
    group by period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_wlzj_yszy materialized query immediate unchecked;
