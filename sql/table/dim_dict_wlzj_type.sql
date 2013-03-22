--
--
--
--
--
drop table dim_dict_wlzj_type;
create table dim_dict_wlzj_type (
    id                  integer       not null primary key,
    name                varchar(128)  not null,
    ts_c                timestamp  default current timestamp
) in tbs_dat index in tbs_idx;


--
-- 往来资金类型
--

comment on table  dim_dict_wlzj_type               is '产品信息字典';
comment on column dim_dict_wlzj_type.id            is 'id';
comment on column dim_dict_wlzj_type.name          is '往来资金类型名称';



-- data

insert into dim_dict_wlzj_type(id, name) values(1, '客户手续费');
insert into dim_dict_wlzj_type(id, name) values(2, '利息收入');

