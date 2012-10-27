Dir['./billingsystem/*.rb'].each {|file| require file }

@an_employee = Employee.new(
  name: 'M. Ployee',
  joining_date: Time.now - 3*Constants::SECONDS_IN_ONE_YEAR)
  
@products = [
  ProductFactory.create_product(name:'Brocolli', price:100, type: Constants::PRODUCT_TYPE_GROCERY),
  ProductFactory.create_product(name:'Apple', price:20, type: Constants::PRODUCT_TYPE_GROCERY),
  ProductFactory.create_product(name:'Quaker Oats', price:200, type: Constants::PRODUCT_TYPE_GROCERY),
  ProductFactory.create_product(name:'Cornflakes', price:150, type: Constants::PRODUCT_TYPE_GROCERY),
  ProductFactory.create_product(name:'Blender', price:1500, type: Constants::PRODUCT_TYPE_ELECTRONICS),
  ProductFactory.create_product(name:'Mobile Phone', price:1000, type: Constants::PRODUCT_TYPE_ELECTRONICS)
] 

@bill = Bill.new(user:@an_employee)
@bill.add_item(product:@products[0], quantity:2)
@bill.add_item(product:@products[1], quantity:1)
@bill.add_item(product:@products[2], quantity:1)
@bill.add_item(product:@products[3], quantity:1)
@bill.add_item(product:@products[4], quantity:20)
@bill.add_item(product:@products[5], quantity:1)

@cashier = Cashier.new
@cashier.process_bill!(bill:@bill)

@bill.print
