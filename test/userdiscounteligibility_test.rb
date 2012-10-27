require File.dirname(__FILE__) + '/../lib/billingsystem/userdiscounteligibility.rb'
require "test/unit"

class UserDiscountEligibilityTest < Test::Unit::TestCase
  def setup
    @var1 = 10
    @var2 = 20
    @var3 = 30
    @var4 = 40
    @var5 = 50
    
    @ude = UserDiscountEligibility.new(discount:@var1)
    @fde1 = FixedDiscountEligibility.new(discount:@var2)
    @fde2 = FixedDiscountEligibility.new(discount:@var3)
    @cde1 = ConditionalDiscountEligibility.new(discount:@var4){|x| x if true}
    @cde2 = ConditionalDiscountEligibility.new(discount:@var5){|x| x unless false}
  end
  
  def test_initialize
    assert_raise(RangeError) {@ude2 = UserDiscountEligibility.new(discount:-1)}
    assert_raise(RangeError) {@ude3 = UserDiscountEligibility.new(discount:101)}
  end
  
  def test_eligible_discount
    assert_raise(NotImplementedError) {@ude.eligible_discount}
    assert_equal(@var2, @fde1.eligible_discount, "FixedDiscountEligibility eligible discount does not match")
    assert_equal(@var3, @fde2.eligible_discount, "FixedDiscountEligibility eligible discount does not match")
    assert_equal(@var4, @cde1.eligible_discount, "ConditionalDiscountEligibility eligible discount does not match")
    assert_equal(@var5, @cde2.eligible_discount, "ConditionalDiscountEligibility eligible discount does not match")
  end
end
