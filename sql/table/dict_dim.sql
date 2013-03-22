--
--
--
--
--
drop table dict_dim;
create table dict_dim (
    dim                 char(30)      not null primary key,
    name                varchar(64)   not null,
    memo                varchar(128)  not null,
    
    ts_c                timestamp  default current timestamp
) in tbs_dat index in tbs_idx;

--
-- 核算项字典表
--

comment on table  dict_dim                   is '核算项字典表';
comment on column dict_dim.dim 		     is '核算项';
comment on column dict_dim.name              is '核算项中文名';
comment on column dict_dim.memo              is '核算项描述';

-- data
insert into dict_dim(dim, name, memo) values('yp_acct', '银行账户号及相应开户行', '银行账户号及相应开户行');
insert into dict_dim(dim, name, memo) values('zjbd_type', '资金变动类型', '资金变动类型');
insert into dict_dim(dim, name, memo) values('zjbd_date', '银行出入账日期', '银行出入账日期');
insert into dict_dim(dim, name, memo) values('c', '客户编号', '客户编号');
insert into dict_dim(dim, name, memo) values('e_date', '差错日期', '差错日期');
insert into dict_dim(dim, name, memo) values('bi', '银行接口编号', '银行接口编号');
insert into dict_dim(dim, name, memo) values('p', '产品类型', '产品类型');
insert into dict_dim(dim, name, memo) values('tx_date', '交易日期', '交易日期');
insert into dict_dim(dim, name, memo) values('wlzj_type', '类型', '类型');
