
select * from employees;
select * from customers;
select * from products;
select * from categories;
select * from shippers;
select * from orders;
select * from order_details;

create table employees(employeeid varchar(100) primary key,
      employeename varchar(100), 
	  title varchar(100),
	  city varchar(100),
	  country varchar(100),
	reportsto integer)

	
create table customers
(customerid varchar(100),
	companyname text,
	contactname text,
	contacttitle text,
	city text,
	country text,
	primary key (customerid)
);

------product table

create table products
(productid integer,
	productname text,
	quantityperunit text,
	unitprice real,
	discontinued integer,
	categoryid integer,
	primary key (productid)	
);

------categories table

create table categories
(categoryid integer,
	categoryname text,
	description text,
	primary key(categoryid)
);

------shippers table

create table shippers
(
	shipperid integer,
	companyname text,
	primary key(shipperid)
);


------orders table

	create table orders(orderid varchar(100) primary key,
          customerid varchar(100) , employeeid varchar(100), 
						   orderdate date,
						   requireddate date,
						   shippeddate date,
						   shipperid integer,
						   freight numeric,
	
	foreign key (customerid) references customers(customerid),	
	foreign key (employeeid) references employees(employeeid),
	foreign key (shipperid) references shippers(shipperid));


------orders_details

create table order_details
(orderid integer not null,
	productid integer,
	unitprice numeric(10, 2),
	quantity integer,
	discount numeric(10, 2),
	primary key (orderid, productid));
