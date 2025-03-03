create procedure CreateOrderFromShoppingCart(@idcustomer int)
as
begin transaction

update products 
	set ProductInventory = ProductInventory - Quantity
	from Products join ShoppingCart
		on Products.ProductSKU = ShoppingCart.ProductSKU;

if exists (select * from Products where ProductInventory<0)
	rollback;
else
begin
	insert into orders (IDCustomer, OrderTotal, OrderDate)
	select IDCustomer, sum(subtotal), getdate()
		from ShoppingCart
		where IDCustomer=@idcustomer
		group by IDCustomer
	insert into OrderDetails
		select @@IDENTITY, ProductSKU, Quantity, Price, SubTotal
		from ShoppingCart
		where IDCustomer=@idcustomer
	delete from ShoppingCart
		where IDCustomer=@idcustomer
	commit
end



select * from Orders;
select * from OrderDetails;
select * from ShoppingCart;
select * from Products;


-- update ShoppingCart set Quantity=2 where ProductSKU = '012345678902'
--update Products set ProductInventory=20 where ProductSKU = '012345678902'