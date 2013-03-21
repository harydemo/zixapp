drop table jzpz;
create table jzpz (

    -- primary key
    id          bigint primary key not null,
    
    j_id       bigint,
    d_id       bigint,
    j_book     int,
    d_book     int,
    ys_type    int,
    ys_id      bigint,
    
    -- misc
    ts_c    timestamp default current timestamp

);


drop sequence seq_jzpz;
create sequence seq_jzpz as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


