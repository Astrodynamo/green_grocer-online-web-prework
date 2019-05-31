def consolidate_cart(cart)
  consolidated_cart = {}
	  cart.map do |hash|
      hash.map do |item, price_hash|
        if consolidated_cart.has_key?(item) == false
          consolidated_cart[item] = price_hash
          consolidated_cart[item][:count] = 1 
        else
          consolidated_cart[item][:count] += 1 
        end
      end
    end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  cart_with_coupons = {}
  
  cart.each do |item, price_hash|
    coupon.each do |coupon|
      if item == coupon[:item] && price_hash[:count] >= coupon[:num]
        price_hash[:count] =  price_hash[:count] - coupon[:num]
        if cart_with_coupons["#{item} W/COUPON"]
          cart_with_coupons["#{item} W/COUPON"][:count] += 1
        else
          cart_with_coupons["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => price_hash[:clearance], :count => 1}
        end
      end
    end
    cart_with_coupons[item] = price_hash
  end
  cart_with_coupons
end

def apply_clearance(cart)
  cart.each do |item, price_hash|
    if price_hash[:clearance]
      price_hash[:price] = (price_hash[:price] * 0.8).round(1) 
    end
  end
end

def checkout(cart, coupons)
  
end
