--
--
--
--
--
drop table dict;
create table dict (
    type                 char(16)    not null,
    key                  varchar(64) not null,
    val                  varchar(512),
    comment              varchar(128) default null,
    ts_c                 timestamp  default current timestamp
) in tbs_dat index in tbs_idx;

-- book
insert into dict( type, key, val, comment) values('book', '2005.02', 'bamt_yhyf',       '应付银行-已核应付银行款' );
insert into dict( type, key, val, comment) values('book', '1020.03', 'bamt_yhys',       '应收银行-已核应收银行款' );
insert into dict( type, key, val, comment) values('book', '2005.03', 'bfee_yhyf',       '应付银行-已核应付银行手续费' );
insert into dict( type, key, val, comment) values('book', '1020.04', 'bfee_yhys',       '应收银行-已核应收银行手续费' );
insert into dict( type, key, val, comment) values('book', '2010.01', 'bfj_cust',       '客户备付金-备付金' );
insert into dict( type, key, val, comment) values('book', '2202.01.001', 'blc',       '应付账款-银行-银行长款' );
insert into dict( type, key, val, comment) values('book', '2202.01.002', 'blc_zyzj',       '应付账款-银行-银行长款' );
insert into dict( type, key, val, comment) values('book', '1122.02.001', 'bsc',       '应收账款-银行-银行短款' );
insert into dict( type, key, val, comment) values('book', '1122.02.002', 'bsc_zyzj',       '应收账款-银行-银行短款' );
insert into dict( type, key, val, comment) values('book', '1122.01.001', 'cfee_dqhf',       '应收账款-客户-定期划付客户手续费' );
insert into dict( type, key, val, comment) values('book', '6421.01', 'cost_bfee',       '成本-银行手续费支出' );
insert into dict( type, key, val, comment) values('book', '6421.02', 'cost_dfss',       '成本-垫付损失' );
insert into dict( type, key, val, comment) values('book', '1002.01', 'deposit_bfj',       '银行存款-备付金存款' );
insert into dict( type, key, val, comment) values('book', '1002.02', 'deposit_zyzj',       '银行存款-自有资金存款' );
insert into dict( type, key, val, comment) values('book', '6603.02', 'fee_jrjg',       '财务费用-金融机构手续费' );
insert into dict( type, key, val, comment) values('book', '6021.01', 'income_cfee',       '收入-客户手续费收入' );
insert into dict( type, key, val, comment) values('book', '6603.01', 'income_zhlx',       '财务费用-账户利息收入' );
insert into dict( type, key, val, comment) values('book', '1020.01', 'txamt_dgd',       '应收银行-待勾兑应收交易款' );
insert into dict( type, key, val, comment) values('book', '2241.01', 'txamt_dqr',       '其他应付款-待确认交易款' );
insert into dict( type, key, val, comment) values('book', '2005.01', 'txamt_yhyf',       '应付银行-已核应付交易款' );
insert into dict( type, key, val, comment) values('book', '1020.02', 'txamt_yhys',       '应收银行-已核应收交易款' );
insert into dict( type, key, val, comment) values('book', '3001.03', 'wlzj_yfbf',       '往来-应付备付' );
insert into dict( type, key, val, comment) values('book', '3001.04', 'wlzj_yfzy',       '往来-应付自有' );
insert into dict( type, key, val, comment) values('book', '3001.01', 'wlzj_ysbf',       '往来-应收备付' );
insert into dict( type, key, val, comment) values('book', '3001.02', 'wlzj_yszy',       '往来-应收自有' );


-- yspz
--insert into dict( type, key, val) values('yspz', '0000', 'yspz_0000');
--insert into dict( type, key, val) values('yspz', '0001', 'yspz_0001');
--insert into dict( type, key, val) values('yspz', '0002', 'yspz_0002');
--insert into dict( type, key, val) values('yspz', '0003', 'yspz_0003');
--insert into dict( type, key, val) values('yspz', '0004', 'yspz_0004');
--insert into dict( type, key, val) values('yspz', '0005', 'yspz_0005');
--insert into dict( type, key, val) values('yspz', '0006', 'yspz_0006');
--insert into dict( type, key, val) values('yspz', '0007', 'yspz_0007');
--insert into dict( type, key, val) values('yspz', '0008', 'yspz_0008');
--insert into dict( type, key, val) values('yspz', '0009', 'yspz_0009');
--insert into dict( type, key, val) values('yspz', '0010', 'yspz_0010');
--insert into dict( type, key, val) values('yspz', '0011', 'yspz_0011');
--insert into dict( type, key, val) values('yspz', '0012', 'yspz_0012');
--insert into dict( type, key, val) values('yspz', '0013', 'yspz_0013');
--insert into dict( type, key, val) values('yspz', '0014', 'yspz_0014');
--insert into dict( type, key, val) values('yspz', '0015', 'yspz_0015');
--insert into dict( type, key, val) values('yspz', '0016', 'yspz_0016');
--insert into dict( type, key, val) values('yspz', '0017', 'yspz_0017');
