insert into Products values ('012345678901', 
	'Strawberry ice cream', 
	'1 liter container with organic ice cream, strawberry flavor',
	100,
	5.49
	);
insert into Products values ('012345678902', 
	'Vanilla ice cream', 
	'1 liter container with organic ice cream, vanilla flavor',
	2,
	5.49
	);
insert into Products values ('012345678903', 
	'Chocolate ice cream', 
	'1 liter container with organic ice cream, chocolate flavor',
	100,
	5.49
	);
insert into Products values ('112345678901', 
	'Chocolate box', 
	'1 pound box, 20 pieces of gourmet dark chocolate truffles',
	50,
	19.99
	);


insert into Customers values (1, 'Bruno Guardia');

insert into ShoppingCart values (1, '112345678901', 3, 19.99, 19.99);
insert into ShoppingCart values (1, '012345678902', 4, 5.49, 16.47);


select * from Products;
select * from Customers;
select * from ShoppingCart;
select * from orders;
select * from orderdetails;

exec CreateOrderFromShoppingCart(1);

