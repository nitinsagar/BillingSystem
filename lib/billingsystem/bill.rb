# Represents the Bill class which needs to be processed and printed
class Bill
  attr_accessor :user, :items, :total, :messages
  
  def initialize(args={})
    @user = args[:user]
    @items = []
    @messages = []
    @total = 0
  end
    
  def add_item(args)
    raise ArgumentError, "quantity must be positive" if args[:quantity]<0
    
    flag = false    
    @items.each do |item|
      if item[:product] == args[:product]
        item[:quantity] += args[:quantity]
        flag = true
      end
    end
    @items << args unless flag
  end
  
  # Must be processed by Cashier class before printing
  def print
    @messages.each {|message| puts message}
  end
  
end  
