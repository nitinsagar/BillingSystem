require File.dirname(__FILE__) + '/../lib/billingsystem/bill.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/user.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/productfactory.rb'
require "test/unit"

class BillTest < Test::Unit::TestCase
  def setup
    @joining_date = Time.now
    @customer = Customer.new(name:'Customer1', joining_date:@joining_date)
    @affiliate = Affiliate.new(name:'Affiliate1', joining_date:@joining_date)
    @employee = Employee.new(name:'Employee1', joining_date:@joining_date)

    @brocolli = ProductFactory.create_product(name:'Brocolli', price:100, type: Constants::PRODUCT_TYPE_GROCERY)
    @apple = ProductFactory.create_product(name:'Apple', price:20, type: Constants::PRODUCT_TYPE_GROCERY)
    @oats = ProductFactory.create_product(name:'Quaker Oats', price:200, type: Constants::PRODUCT_TYPE_GROCERY)
    @cornflakes = ProductFactory.create_product(name:'Cornflakes', price:150, type: Constants::PRODUCT_TYPE_GROCERY)
    @blender = ProductFactory.create_product(name:'Blender', price:1500, type: Constants::PRODUCT_TYPE_ELECTRONICS)
    @mobile_phone = ProductFactory.create_product(name:'Mobile Phone', price:1000, type: Constants::PRODUCT_TYPE_ELECTRONICS)

    @bill1 = Bill.new(user:@customer)
    @bill2 = Bill.new(user:@affiliate)
    @bill3 = Bill.new(user:@employee)
    
    @bill1.messages << "M1" << "M2"
    @bill2.messages << "M3M4M5"
    
    @bill1.add_item(product:@brocolli, quantity:2)
    @bill1.add_item(product:@apple, quantity:1)
    @bill2.add_item(product:@oats, quantity:10)
  end
  
  def test_user
    assert_equal(@customer, @bill1.user, "Bill user does not match")
    assert_equal(@affiliate, @bill2.user, "Bill user does not match")
    assert_equal(@employee, @bill3.user, "Bill user does not match")
  end
  
  def test_messages
    assert_equal(["M1", "M2"], @bill1.messages, "Bill messages does not match")
    assert_equal(["M3M4M5"], @bill2.messages, "Bill messages does not match")
    assert_equal([], @bill3.messages, "Bill messages does not match")
  end
  
  def test_total
    assert_equal(0, @bill1.total, "Bill total does not match")    
    assert_equal(0, @bill2.total, "Bill total does not match")    
    assert_equal(0, @bill3.total, "Bill total does not match")    
  end
  
  def test_items
    assert_equal([{:product=>@brocolli, :quantity=>2},{:product=>@apple, :quantity=>1}], @bill1.items, "Bill items do not match")
    assert_equal([{:product=>@oats, :quantity=>10}], @bill2.items, "Bill items do not match")
    assert_equal([], @bill3.items, "Bill items do not match")
  end

  def test_add_item
    assert_raise(ArgumentError) {@bill1.add_item(product:@brocolli, quantity:-1)}
    
    @bill1.add_item(product:@brocolli, quantity:3)
    @bill2.add_item(product:@blender, quantity:3)
    @bill3.add_item(product:@mobile_phone, quantity:3)
    
    assert_equal([{:product=>@brocolli, :quantity=>5},{:product=>@apple, :quantity=>1}], @bill1.items, "Bill items do not match")
    assert_equal([{:product=>@oats, :quantity=>10},{:product=>@blender, :quantity=>3}], @bill2.items, "Bill items do not match")
    assert_equal([{:product=>@mobile_phone, :quantity=>3}], @bill3.items, "Bill items do not match")
  end
  
  
end
