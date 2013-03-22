drop table book_bamt_yhyf;
create table book_bamt_yhyf (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    b_acct      char(32),
    b_name      varchar(128),
    zjbd_type   char(2),
    b_crz_date  char(8),
    
    -- jz data
    j       bigint,
    d       bigint,

    --
    ys_id       bigint not null,
    ys_type     int    not null,
    jzpz_id     int    not null,
    
    -- misc
    ts_c    timestamp default current timestamp

);


drop sequence seq_bamt_yhyf;
create sequence seq_bamt_yhyf as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;
