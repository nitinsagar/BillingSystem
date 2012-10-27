require File.dirname(__FILE__) + '/../lib/billingsystem/productfactory.rb'
require "test/unit"

class ProductFactoryTest < Test::Unit::TestCase
  def setup
    @brocolli = ProductFactory.create_product(name:'Brocolli', price:100, type: Constants::PRODUCT_TYPE_GROCERY)
    @apple = ProductFactory.create_product(name:'Apple', price:20, type: Constants::PRODUCT_TYPE_GROCERY)
    @oats = ProductFactory.create_product(name:'Quaker Oats', price:200, type: Constants::PRODUCT_TYPE_GROCERY)
    @cornflakes = ProductFactory.create_product(name:'Cornflakes', price:150, type: Constants::PRODUCT_TYPE_GROCERY)
    @blender = ProductFactory.create_product(name:'Blender', price:1500, type: Constants::PRODUCT_TYPE_ELECTRONICS)
    @mobile_phone = ProductFactory.create_product(name:'Mobile Phone', price:1000, type: Constants::PRODUCT_TYPE_ELECTRONICS)
  end
  
  def test_create_product
    assert_raise(RangeError) {@brocolli = ProductFactory.create_product(name:'Orange', price:-1, type: Constants::PRODUCT_TYPE_GROCERY)}
  end
  
  def test_name
    assert_equal('Brocolli', @brocolli.name, 'Brocolli name does not match')    
    assert_equal('Apple', @apple.name, 'Apple name does not match')    
    assert_equal('Quaker Oats', @oats.name, 'Quaker Oats name does not match')    
    assert_equal('Cornflakes', @cornflakes.name, 'Cornflakes name does not match')    
    assert_equal('Blender', @blender.name, 'Blender name does not match')    
    assert_equal('Mobile Phone', @mobile_phone.name, 'Mobile Phone name does not match')    
  end
  
  def test_price
    assert_equal(100, @brocolli.price, 'Brocolli price does not match')    
    assert_equal(20, @apple.price, 'Apple price does not match')    
    assert_equal(200, @oats.price, 'Quaker Oats price does not match')    
    assert_equal(150, @cornflakes.price, 'Cornflakes price does not match')    
    assert_equal(1500, @blender.price, 'Blender name price not match')    
    assert_equal(1000, @mobile_phone.price, 'Mobile Phone price does not match')    
  end
  
  def test_type
    assert_equal(Constants::PRODUCT_TYPE_GROCERY, @brocolli.type, 'Brocolli type does not match')    
    assert_equal(Constants::PRODUCT_TYPE_GROCERY, @apple.type, 'Apple type does not match')    
    assert_equal(Constants::PRODUCT_TYPE_GROCERY, @oats.type, 'Quaker Oats type does not match')    
    assert_equal(Constants::PRODUCT_TYPE_GROCERY, @cornflakes.type, 'Cornflakes type does not match')    
    assert_equal(Constants::PRODUCT_TYPE_ELECTRONICS, @blender.type, 'Blender type does not match')    
    assert_equal(Constants::PRODUCT_TYPE_ELECTRONICS, @mobile_phone.type, 'Mobile Phone type does not match')    
  end

  def test_discountable
    assert_equal(false, @brocolli.discountable, 'Brocolli discountable does not match')    
    assert_equal(false, @apple.discountable, 'Apple discountable does not match')    
    assert_equal(false, @oats.discountable, 'Quaker Oats discountable does not match')    
    assert_equal(false, @cornflakes.discountable, 'Cornflakes discountable does not match')    
    assert_equal(true, @blender.discountable, 'Blender name discountable not match')    
    assert_equal(true, @mobile_phone.discountable, 'Mobile Phone discountable does not match')    
  end
end
