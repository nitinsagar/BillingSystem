require File.dirname(__FILE__) + '/../lib/billingsystem/constants.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/cashier.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/bill.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/user.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/productfactory.rb'
require "test/unit"

class CashierTest < Test::Unit::TestCase
  def setup
    @joining_date = Time.now
    @customer = Customer.new(name:'Customer1', joining_date:@joining_date)
    @affiliate = Affiliate.new(name:'Affiliate1', joining_date:@joining_date)
    @employee = Employee.new(name:'Employee1', joining_date:@joining_date)
    @customer_old = Customer.new(name:'Customer2', joining_date:@joining_date - 2*Constants::SECONDS_IN_ONE_YEAR - 1)

    @brocolli = ProductFactory.create_product(name:'Brocolli', price:100, type: Constants::PRODUCT_TYPE_GROCERY)
    @apple = ProductFactory.create_product(name:'Apple', price:20, type: Constants::PRODUCT_TYPE_GROCERY)
    @oats = ProductFactory.create_product(name:'Quaker Oats', price:200, type: Constants::PRODUCT_TYPE_GROCERY)
    @cornflakes = ProductFactory.create_product(name:'Cornflakes', price:150, type: Constants::PRODUCT_TYPE_GROCERY)
    @blender = ProductFactory.create_product(name:'Blender', price:1500, type: Constants::PRODUCT_TYPE_ELECTRONICS)
    @mobile_phone = ProductFactory.create_product(name:'Mobile Phone', price:1000, type: Constants::PRODUCT_TYPE_ELECTRONICS)

    @bill1 = Bill.new(user:@customer)
    @bill2 = Bill.new(user:@affiliate)
    @bill3 = Bill.new(user:@employee)
    @bill4 = Bill.new(user:@customer_old)
    
    @bill1.add_item(product:@brocolli, quantity:2)
    @bill1.add_item(product:@apple, quantity:1)
    @bill1.add_item(product:@blender, quantity:10)
    @bill2.add_item(product:@oats, quantity:10)
    @bill2.add_item(product:@blender, quantity:10)
    @bill3.add_item(product:@cornflakes, quantity:10)
    @bill3.add_item(product:@blender, quantity:10)
    @bill4.add_item(product:@brocolli, quantity:10)
    @bill4.add_item(product:@mobile_phone, quantity:10)
    
    @cashier = Cashier.new
  end
  
  def test_process_user_based_discount
    @cashier.process_user_based_discount!(bill:@bill1)
    @cashier.process_user_based_discount!(bill:@bill2)
    @cashier.process_user_based_discount!(bill:@bill3)
    @cashier.process_user_based_discount!(bill:@bill4)
    
    assert_equal(100*2 + 20*1 + 1500*10, @bill1.total, "Cashier process user based discount's outcome does not match")
    assert_equal(200*10 + 1500*10*0.9, @bill2.total, "Cashier process user based discount's outcome does not match")
    assert_equal(150*10 + 1500*10*0.7, @bill3.total, "Cashier process user based discount's outcome does not match")
    assert_equal(100*10 + 1000*10*0.95 , @bill4.total, "Cashier process user based discount's outcome does not match")
  end
  
  def test_process_amount_based_discount
    @cashier.process_user_based_discount!(bill:@bill1)
    @cashier.process_user_based_discount!(bill:@bill2)
    @cashier.process_user_based_discount!(bill:@bill3)
    @cashier.process_user_based_discount!(bill:@bill4)
    
    @cashier.process_amount_based_discount!(bill:@bill1)
    @cashier.process_amount_based_discount!(bill:@bill2)
    @cashier.process_amount_based_discount!(bill:@bill3)
    @cashier.process_amount_based_discount!(bill:@bill4)

    assert_equal(15220 - 152*5, @bill1.total, "Cashier process amount based discount's outcome does not match")
    assert_equal(15500 - 155*5, @bill2.total, "Cashier process amount based discount's outcome does not match")
    assert_equal(12000 - 120*5, @bill3.total, "Cashier process amount based discount's outcome does not match")
    assert_equal(10500 - 105*5, @bill4.total, "Cashier process amount based discount's outcome does not match")
  end
  
end
