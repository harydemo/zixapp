drop table yspz_0002;
create table yspz_0002 (

    -- primary key
    id          bigint primary key not null,
    desc        varchar(128),
    
    -- misc
    ts_u    timestamp,
    ts_c    timestamp default current timestamp

);


drop sequence seq_yspz_0002;
create sequence seq_yspz_0002 as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;
