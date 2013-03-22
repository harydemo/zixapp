--
--
--
--
--
drop table dim_dict_product;
create table dim_dict_product (
    id                  integer       not null primary key,
    p_num               char(18)      not null,
    name                varchar(128)  not null,
    des                 varchar(1024),
    ts_c                timestamp  default current timestamp
) in tbs_dat index in tbs_idx;


--
-- 产品信息字典
--

comment on table  dim_dict_product               is '产品信息字典';
comment on column dim_dict_product.id            is 'id';
comment on column dim_dict_product.p_num         is '产品编号';
comment on column dim_dict_product.name          is '产品名称';
comment on column dim_dict_product.des           is '产品描述';



-- data

insert into dim_dict_product(id, p_num, name, des) values(1, '1', '直联银联POS收单', '直联银联POS收单');
insert into dim_dict_product(id, p_num, name, des) values(2, '2', '结算', '结算');

