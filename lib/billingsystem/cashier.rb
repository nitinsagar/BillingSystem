require File.dirname(__FILE__) + '/constants.rb'

# Represents class responsible for processing the discounts on the bill
class Cashier
  
  # Process the discounts on the bill
  def process_bill!(args)
    
    bill = args[:bill]
    
    bill.messages << [Constants::HORIZONTAL_SPACER, 
      "Bill generated: #{Time.now}", 
      bill.user, Constants::HORIZONTAL_SPACER]    

    process_user_based_discount!(args)
    process_amount_based_discount!(args)

    bill.messages << ["Net Payable Amount: #{bill.total.to_s}", 
      Constants::HORIZONTAL_SPACER]    
  end
  
  # Process the User/Percentage based discount
  def process_user_based_discount!(args)
    bill = args[:bill]
    discount = (100.0 - bill.user.eligible_discount) / 100.0
    bill.total = 0.0
    bill.items.each do |item| 
      amount_pre_discount = item[:product].price * item[:quantity]
      amount_post_discount = amount_pre_discount
      amount_post_discount *= discount if item[:product].discountable
      bill.total += amount_post_discount
      bill.messages << "#{item[:product].name}\n  #{item[:product].type}, \tQuantity: #{item[:quantity].to_s}\n  Pre-discounted Amount: #{amount_pre_discount.to_s}, \tFinal Amount: #{amount_post_discount.to_s}"
    end
    bill.messages << Constants::HORIZONTAL_SPACER    
  end
  
  # Process the discount on the final amount
  def process_amount_based_discount!(args)

    bill = args[:bill]
    multiples_of_amount_base = bill.total.divmod(Constants::BILL_AMOUNT_MULTIPLE)[0]
    amount_based_discount = multiples_of_amount_base*Constants::BILL_AMOUNT_DISCOUNT

    if amount_based_discount > 0
      bill.messages << ["Total Amount Before Discount: #{bill.total.to_s}", 
        "You are eligible for a further discount of #{amount_based_discount}!",
        Constants::HORIZONTAL_SPACER]    
    end

    bill.total = bill.total - amount_based_discount
  end

end