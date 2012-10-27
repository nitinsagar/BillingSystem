require File.dirname(__FILE__) + '/../lib/billingsystem/user.rb'
require File.dirname(__FILE__) + '/../lib/billingsystem/constants.rb'
require "test/unit"

class UserTest < Test::Unit::TestCase
  def setup
    @joining_date = Time.now
    @user = User.new(name:'User1', joining_date:@joining_date)
    @customer = Customer.new(name:'Customer1', joining_date:@joining_date)
    @customer_old = Customer.new(name:'Customer2', joining_date:@joining_date - 2*Constants::SECONDS_IN_ONE_YEAR - 1)
    @customer_boundary = Customer.new(name:'Customer3', joining_date:@joining_date - 2*Constants::SECONDS_IN_ONE_YEAR + 1)
    @affiliate = Affiliate.new(name:'Affiliate1', joining_date:@joining_date)
    @employee = Employee.new(name:'Employee1', joining_date:@joining_date)
  end

  def test_initialize
      assert_raise(TypeError) {@affiliate2 = Affiliate.new(name:'Affiliate1', joining_date:"abc")}
  end
  
  def test_name
    assert_equal('User1', @user.name, 'User name does not match')
    assert_equal('Customer1', @customer.name, 'Customer name does not match')
    assert_equal('Customer2', @customer_old.name, 'Customer name does not match')
    assert_equal('Customer3', @customer_boundary.name, 'Customer name does not match')
    assert_equal('Affiliate1', @affiliate.name, 'Affiliate name does not match')
    assert_equal('Employee1', @employee.name, 'Employee name does not match')
  end
  
  def test_joining_date
    assert_equal(@joining_date, @user.joining_date, 'User joining date does not match')
    assert_equal(@joining_date, @customer.joining_date, 'Customer joining date does not match')
    assert_equal(@joining_date - 2*Constants::SECONDS_IN_ONE_YEAR - 1, @customer_old.joining_date, 'Customer joining date does not match')
    assert_equal(@joining_date - 2*Constants::SECONDS_IN_ONE_YEAR + 1, @customer_boundary.joining_date, 'Customer joining date does not match')
    assert_equal(@joining_date, @affiliate.joining_date, 'Affiliate joining date does not match')
    assert_equal(@joining_date, @employee.joining_date, 'Employee joining date does not match')
  end
  
  def test_type
    assert_equal('User', @user.type, 'User type does not match')
    assert_equal('Customer', @customer.type, 'Customer type does not match')
    assert_equal('Customer', @customer_old.type, 'Customer type does not match')
    assert_equal('Customer', @customer_boundary.type, 'Customer type does not match')
    assert_equal('Affiliate', @affiliate.type, 'Affiliate type does not match')
    assert_equal('Employee', @employee.type, 'Employee type does not match')
  end
  
  def test_eligible_discount
    assert_raise(NoMethodError) {@user.eligible_discount}
    assert_equal(0, @customer.eligible_discount, 'Customer eligible discount does not match')
    assert_equal(5, @customer_old.eligible_discount, 'Customer eligible discount does not match')
    assert_equal(0, @customer_boundary.eligible_discount, 'Customer eligible discount does not match')
    assert_equal(10, @affiliate.eligible_discount, 'Affiliate eligible discount does not match')
    assert_equal(30, @employee.eligible_discount, 'Employee eligible discount does not match')
  end

end