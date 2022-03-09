create table orders(
    cid number(9), 
    bid number(9),
    primary key(cid,bid),
    foreign key (cid) references customers,
    foreign key (bid) references books,
    quantity number(6)
);

insert into orders
values(001, 001, 1);
insert into orders
values(001, 002, 1);
insert into orders
values(001, 003, 1);
insert into orders
values(001, 004, 1);
insert into orders
values(001, 005, 1);
insert into orders
values(001, 006, 1);
insert into orders
values(001, 007, 1);
insert into orders
values(001, 008, 1);
insert into orders
values(001, 009, 1);
insert into orders
values(001, 010, 1);
insert into orders
values(001, 011, 1);
insert into orders
values(001, 012, 1);
insert into orders
values(001, 013, 1);
insert into orders
values(001, 014, 1);
insert into orders
values(001, 015, 1);
insert into orders
values(001, 016, 1);
insert into orders
values(001, 017, 1);
insert into orders
values(001, 018, 1);
insert into orders
values(001, 019, 1);
insert into orders
values(001, 020, 1);
values(001, 021, 1);
insert into orders
values(001, 022, 1);
insert into orders
values(001, 023, 1);
insert into orders
values(001, 024,1);
insert into orders
values(001, 025, 1);
insert into orders
values(001, 026, 1);
insert into orders
values(001, 027, 1);
insert into orders
values(001, 028, 1);
insert into orders
values(001, 029, 1);
insert into orders
values(001, 030,1);
insert into orders
values(001, 031, 1);
insert into orders
values(001, 032, 1);
insert into orders
values(001, 033, 1);
insert into orders
values(001, 034, 1);
insert into orders
values(001, 035,1);
insert into orders
values(001, 036, 1);

insert into orders  
values(002,001, 21); 
insert into orders
values(002,002, 21); 
insert into orders
values(002,003, 21); 
insert into orders
values(002,004, 21); 
insert into orders
values(002,005, 21); 
insert into orders
values(002,006, 21); 
insert into orders
values(002,007, 21); 
insert into orders
values(002,008, 21); 
insert into orders
values(002,009, 21); 
insert into orders
values(002,010, 21); 
insert into orders
values(002,011, 21); 
insert into orders
values(002,012, 21); 
insert into orders
values(002,013, 21); 
insert into orders
values(002,014, 21); 
insert into orders
values(002,015, 21); 
insert into orders
values(002,016, 21); 
insert into orders
values(002,017, 21); 
insert into orders
values(002,018, 21); 
insert into orders
values(002,019, 21); 
insert into orders
values(002,020, 21); 
insert into orders 
values(002,021, 21); 
insert into orders
values(002,022, 21); 
insert into orders
values(002,023, 21); 
insert into orders
values(002,024, 21); 
insert into orders
values(002,025, 21); 
insert into orders
values(002,026, 21); 
insert into orders
values(002,027, 21); 
insert into orders
values(002,028, 21); 
insert into orders
values(002,029, 21); 
insert into orders
values(002,030, 21); 
insert into orders
values(002,031, 21); 
insert into orders
values(002,032, 21); 
insert into orders
values(002,033, 21); 
insert into orders
values(002,034, 21); 
insert into orders
values(002,035, 21); 
insert into orders
values(002,036, 21);

insert into orders 
values(003, 003, 50); 
insert into orders 
values(004, 004, 1); 
insert into orders  
values(005, 005, 22);

select * from orders;