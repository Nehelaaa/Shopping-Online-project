drop table sales;
drop table products;
drop table customers;

create table products (
			pid number(4) primary key,
			name varchar(20),
			price number(4)
);
insert into products values(1000,'Television',10);
insert into products values(1002,'Cell phone',30);
insert into products values(1003,'Mac Book Air',20);
insert into products values(1004,'Apple watch',10);
insert into products values(1005,'Power bank',15);

create table customers (
			cid int primary key,
			name varchar(20),
			budget number(4)
);
insert into customers values(100,'Shujaullah',100);
insert into customers values(102,'Kevin',200);
insert into customers values(103,'Zhi',300);
insert into customers values(104,'Sean',400);
insert into customers values(105,'Ananya',500);

create table sales(
			cid number(9),
			pid number(9),
			foreign key (cid) references customers,
			foreign key (pid) references products,
			quantity number(4)
);
select * from customers;
select * from products;
select * from sales;