# Module containing constant literal values
module Constants

  FIXED_DISCOUNT_IN_PERCENTAGE_EMPLOYEE = 30
  FIXED_DISCOUNT_IN_PERCENTAGE_AFFILIATE = 10

  CONDITIONAL_DISCOUNT_IN_PERCENTAGE_CUSTOMER = 5
  
  CONDITION_TIME_PERIOD_IN_YEARS_CUSTOMER = 2
  
  BILL_AMOUNT_MULTIPLE = 100.0
  BILL_AMOUNT_DISCOUNT = 5.0

  USER_TYPE_EMPLOYEE = 'Employee'
  USER_TYPE_AFFILIATE = 'Affiliate'
  USER_TYPE_CUSTOMER = 'Customer'
  
  PRODUCT_TYPE_GROCERY = 'Grocery'
  PRODUCT_TYPE_ELECTRONICS = 'Electronics'
  
  PRODUCTS_NON_DISCOUNTABLE = [PRODUCT_TYPE_GROCERY]


  SECONDS_IN_ONE_YEAR = 365*24*60*60
  HORIZONTAL_SPACER = '-'*60
  
end