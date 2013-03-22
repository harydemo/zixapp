--
drop table book_wlzj_yfzy;
create table book_wlzj_yfzy (

    -- primary key
    id               bigint primary key not null,
    
    -- dimension
    wlzj_type     integer      not null,
    -- dimension (tp)
    period      date         not null,
    
    -- jz data
    j            bigint default 0 not null,
    d            bigint default 0 not null,

    -- jzpz 
    ys_type          char(4)      not null,
    ys_id            bigint       not null,
    jzpz_id          bigint       not null,

    
    -- misc
    --rec_c_ts    timestamp default current timestamp
    ts_c        timestamp default current timestamp

) in tbs_dat index in tbs_idx;


drop sequence seq_wlzj_yfzy;
create sequence seq_wlzj_yfzy as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


--
-- 往来 - 应付自有 
--


comment on table  book_wlzj_yfzy is '往来 - 应付自有';
comment on column book_wlzj_yfzy.id                 is '主键';
comment on column book_wlzj_yfzy.wlzj_type       is '类型';
comment on column book_wlzj_yfzy.period     is '会计期间';
comment on column book_wlzj_yfzy.j              is '借方发生额';




--MQT
create table sum_wlzj_yfzy as (
    select wlzj_type  as wlzj_type,
	   period     as period,
	   sum(j)     as j,
	   sum(d)     as d,
	   count(*)   as cnt
    from book_wlzj_yfzy
    group by wlzj_type, period
)
data initially deferred refresh immediate
in tbs_dat;


-- integrity unchecked
set integrity for sum_wlzj_yfzy materialized query immediate unchecked;
