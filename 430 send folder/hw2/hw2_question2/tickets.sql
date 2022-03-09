 create table tickets (
    pid number(9),
    fid number(9),
    foreign key (pid) references passengers,
    foreign key (fid) references flights,
    price number(4)
);

insert into tickets 
values(001, 001, 20);
insert into tickets 
values(001, 002, 10);
insert into tickets 
values(001, 003, 15);
insert into tickets 
values(001, 004, 5);
insert into tickets 
values(001, 005, 6);
insert into tickets 
values(002, 001, 3);
insert into tickets 
values(002, 005, 12);
insert into tickets 
values(003, 001, 40);
insert into tickets 
values(004, 003, 60);
insert into tickets
values(006, 001, 9);
insert into tickets 
values(007, 001, 10);
insert into tickets 
values(005, 001, 11);
insert into tickets 
values(008, 001, 12);
insert into tickets 
values(004, 001, 13);
insert into tickets
values(006, 003, 1);
insert into tickets 
values(007, 003, 2);
insert into tickets 
values(005, 002, 3);
insert into tickets 
values(008, 002, 4);
insert into tickets 
values(004, 002, 5);
