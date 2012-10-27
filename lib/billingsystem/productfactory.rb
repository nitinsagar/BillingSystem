require File.dirname(__FILE__) + '/constants.rb'
require 'ostruct'

# Represents a factory for creating product object, 
# the type of which determines if it is discountable
module ProductFactory

  # Sets name and price of the product
  def self.create_product(args)
    raise RangeError, "price must be positive" if args[:price]<0
    
    # checks for product type in array of non-discountable types
    if Constants::PRODUCTS_NON_DISCOUNTABLE.include?(args[:type]) then discountable = false else discountable = true end
    OpenStruct.new(
      name: args[:name],
      price: args[:price],
      type: args[:type],
      discountable: discountable
    )
  end
end
