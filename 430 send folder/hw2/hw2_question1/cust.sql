create table customers(
    cid number(9) primary key,
    cname varchar(20),
    zipcode varchar(5)
);

insert into customers
values(001, 'sara', '12345');
insert into customers
values(002, 'krishna', '11111');
insert into customers
values(003, 'ananya', '02125');
insert into customers
values(004, 'jaz', '02125');
insert into customers
values(005, 'zara','54321');

select * from customers;