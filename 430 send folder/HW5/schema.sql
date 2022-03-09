drop table registration;
drop table campers;
drop table activities;

create table campers(
    cid number(9) primary key,
    name varchar(20),
    age number(3),
    zipcode number(5)
);
insert into campers values (1,'Li',21,0000);
insert into campers values (2,'shuja',19,0001);
insert into campers values (3,'sara',21,0002);
insert into campers values (4,'aanb',25,0003);
insert into campers values (5,'zhi',20,0004);

create table activities(
    aid number(9) primary key,
    name varchar(20),
    price number(4),
    capacity number(4)
);

insert into activities values(2001,'hiking',10,25);
insert into activities values(2002,'hunting',40,10);
insert into activities values(2003,'scavenger hunt',10,30);
insert into activities values(2004,'tag',1,10);
insert into activities values(2005,'running',10,20);
insert into activities values(2006,'bourn fire',10,10);

create table registration(
    cid number(9),
    aid number(9),
    foreign key(cid) references campers,
    foreign key(aid) references activities
);
insert into registration values(2,2001);
insert into registration values(3,2001);
insert into registration values(4,2001);
insert into registration values(5,2001);
insert into registration values(1,2002);
insert into registration values(5,2002);
insert into registration values(3,2005);
insert into registration values(4,2005);
insert into registration values(4,2004);
insert into registration values(2,2005);
insert into registration values(5,2006);
insert into registration values(2,2006);