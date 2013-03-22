--
--
--
--
--
--
--
--
--
-- ************************
drop table jzpz;
create table jzpz (

    id                   bigint primary key not null,
    
    j_id                 bigint     not null,
    d_id                 bigint     not null,
    j_book               char(4)    not null,
    d_book               char(4)    not null,
    ys_type              char(4)    not null,
    ys_id                bigint     not null,
    mark                 char(10),

    --tp
    period               date       not null,
    
    ts_c                 timestamp  default current timestamp
  
) in tbs_dat index in tbs_idx; 

drop sequence seq_jzpz;
create sequence seq_jzpz as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;



