require File.dirname(__FILE__) + '/constants.rb'
require File.dirname(__FILE__) + '/userdiscounteligibility.rb'

# Represents the User base model 
class User
  attr_accessor :name, :joining_date
  
  # Sets the name and joining date
  def initialize(args={})
    raise TypeError, "joining_date must be of type Time" unless args[:joining_date].is_a?(Time)
     
    @name = args[:name]
    @joining_date = args[:joining_date] 
    @discount_eligibility = nil
  end

  # The eligible discount applicable to the User is delegated
  # to the eligibility behaviour class
  def eligible_discount
    @discount_eligibility.eligible_discount
  end

  def type
    self.class.to_s
  end
  
  def to_s
    "#@name (#{type}), Eligible discount: #{eligible_discount.to_s}%"
  end
end

# Represents the user type Employee
class Employee < User

  # Sets the name, joining date and fixed percentage discount eligibility behaviour
  def initialize(args)
    super(args)
        
    @discount_eligibility = FixedDiscountEligibility.new(discount: Constants::FIXED_DISCOUNT_IN_PERCENTAGE_EMPLOYEE) 
  end  
end

# Represents the user type Affiliate
class Affiliate < User

  # Sets the name, joining date and fixed percentage discount eligibility behaviour
  def initialize(args)
    super(args)
    
    @discount_eligibility = FixedDiscountEligibility.new(discount: Constants::FIXED_DISCOUNT_IN_PERCENTAGE_AFFILIATE) 
  end  
end

# Represents the user type Customer
class Customer < User
  
  # Sets the name, joining date and conditional discount eligibility behaviour
  # which depends on the joining date of the user
  def initialize(args)
    super(args)
    
    @discount_eligibility = ConditionalDiscountEligibility.new(discount: Constants::CONDITIONAL_DISCOUNT_IN_PERCENTAGE_CUSTOMER){|discount|  if ((Time.now - self.joining_date)/(Constants::SECONDS_IN_ONE_YEAR) > Constants::CONDITION_TIME_PERIOD_IN_YEARS_CUSTOMER) then discount else 0.0 end } 
  end  
end