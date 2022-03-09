create table flights(
    fid number(9) primary key,
    "from" varchar(20),
    tto varchar(20),
    miles number(4), 
    aircraft varchar(10)
);
insert into flights
values (001, 'boston', 'cali', 0100,'b787');
insert into flights
values (002, 'boston', 'ny', 2000,'b737');
insert into flights
values (003, 'haiti', 'miami', 300,'b320');
insert into flights
values (004, 'germany', 'spain', 1000,'b777');
insert into flights
values (005, 'germany', 'spain', 1000,'b778');