drop table book_bfee_yhyf;
create table book_bfee_yhyf (

    -- primary key
    id          bigint primary key not null,
    
    -- dimension
    b_acct      char(32)     ,
    b_name      varchar(128) ,
    zjbd_type   char(2)      ,
    b_crz_date  char(8)      ,
    
    -- jz data
    j_amt       bigint default 0,
    d_amt       bigint default 0,

    ys_type    int,
    ys_id      bigint,
    jzpz_id    bigint,
    
    -- misc
    ts_c    timestamp default current timestamp

);


drop sequence seq_bfee_yhyf;
create sequence seq_bfee_yhyf as bigint start with 1 increment by 1 minvalue 1 no maxvalue no cycle no cache order;


