create table sailors(
        sid 	number(9) primary key,
        sname	varchar(20),
        rating  number(2),
        age   	number(4,2)
);

create table boats(
	bid 	number(9) primary key,
	name	varchar(20),
	color	varchar(20)
);

create table reserves(
	sid 	number(9),
	bid 	number(9),
	primary key(sid,bid),
	foreign key (sid) references sailors,
	foreign key (bid) references boats
);
