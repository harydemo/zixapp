--
--
--
--
--
drop table dim_dict_yp_acct;
create table dim_dict_yp_acct (
-- primary key
    id                  integer  primary key not null,
    b_acct              char(32)             not null,
    acct_type           char(2)              not null,
    acct_name           varchar(128)         not null,
    b_code              char(18)             not null,
    b_name              varchar(128)         not null,
    b_stlmnt_num        char(18)             not null,
    
-- mis
    ts_c                timestamp  default current timestamp
) in tbs_dat index in tbs_idx;


--
-- 易宝资金账户号字典
--

comment on table   dim_dict_yp_acct               is '易宝资金账户号字典';
comment on column  dim_dict_yp_acct.id            is 'id';
comment on column  dim_dict_yp_acct.b_acct        is '资金账户账户号';
comment on column  dim_dict_yp_acct.acct_type     is '资金账户类型. 0 备付金账户; 1 自有资金账户';
comment on column  dim_dict_yp_acct.acct_name     is '开户名';
comment on column  dim_dict_yp_acct.b_code        is '开户行号';
comment on column  dim_dict_yp_acct.b_name        is '开户行名称';
comment on column  dim_dict_yp_acct.b_stlmnt_num  is '开户行清算号';


-- data
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(1, '002477419700010', '0', '北京通融通信息技术有限公司', '', '包商银行北京分行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(2, '00130630500120109167292', '0', '北京通融通信息技术有限公司', '', '北京银行上海分行营业部', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(3, '2107590019300023518', '0', '北京通融通信息技术有限公司', '', '工商银行广西钦州分行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(4, '2107590019300055838', '0', '北京通融通信息技术有限公司', '', '工商银行广西钦州分行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(5, '35310188000063804', '0', '北京通融通信息技术有限公司', '', '光大银行北京京广桥支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(6, '01541100000425', '0', '北京通融通信息技术有限公司', '', '河北银行朝阳路支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(7, '11001042500053001473', '0', '北京通融通信息技术有限公司', '', '建设银行北京建国支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(8, '41-004300040017055', '0', '北京通融通信息技术有限公司', '', '农业银行深圳上步支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(9, '2000004743525', '0', '北京通融通信息技术有限公司', '', '平安银行上海张江支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(10, '2000007916325', '0', '北京通融通信息技术有限公司', '', '平安银行深圳分行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(11, '91350154800005063', '0', '北京通融通信息技术有限公司', '', '浦发银行北京北沙滩支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(12, '91350154800005071', '0', '北京通融通信息技术有限公司', '', '浦发银行北京北沙滩支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(13, '017014908-03001762876', '0', '北京通融通信息技术有限公司', '', '上海银行北京分行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(14, '905000120190019139', '0', '北京通融通信息技术有限公司', '', '温州银行上海分行营业部', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(15, '100527227860010004', '0', '北京通融通信息技术有限公司', '', '中国邮政储蓄银行广州荔湾支行', '');
insert into dim_dict_yp_acct(id, b_acct, acct_type, acct_name, b_code, b_name, b_stlmnt_num) values(16, '774459222622', '0', '北京通融通信息技术有限公司', '', '中国银行深圳建安路支行', '');

