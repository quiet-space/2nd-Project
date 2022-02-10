use mysql;
create database roomdb;
use roomdb;

create table user(
 userid varchar(20) PRIMARY key,
 userpw varchar(20),
 useremail varchar(20),
 userpn varchar(10)
 );

create table freeboard(
fbn int not null auto_increment primary key,
fbo varchar(50),
userid varchar(20),
fbd DateTIme,
fbrcontent varchar(2048),
fbavaliable int);

select * from freeboard;
select * from user;

commit;