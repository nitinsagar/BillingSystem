# Represents user's discount eligibility behaviour
class UserDiscountEligibility
  
  def initialize(args={})
   raise RangeError, "discount must be between 0 and 100" unless (1..100).include?(args[:discount])
   
    @discount = args[:discount]
  end
  
  def eligible_discount
    raise NotImplementedError, 
      "This #{self.class} cannot respond to:"
  end
  
end

# Represents the user's fixed percentage discount eligibility behavior
class FixedDiscountEligibility < UserDiscountEligibility
  
  def eligible_discount
    @discount
  end
end

# Represents the user's conditional discount eligibility behaviour
class ConditionalDiscountEligibility < UserDiscountEligibility
  
  def initialize(args, &condition)
    super(args)
    @condition = condition
  end
  
  def eligible_discount
    @condition.call(@discount)
  end
end

