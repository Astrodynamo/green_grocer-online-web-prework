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
  total = 0 
  cart = consolidate_cart(cart)

  if cart.length == 1 
    cart = apply_coupons(cart, coupon)
    cart_discount = apply_clearance(cart)
    if cart.length > 1 
      cart_discount.map do |item, price_hash|
        if price_hash[:count] >= 1 
          total += (price_hash[:price] * price_hash[:count])
        end
      end
    else 
      cart_discount.map do |item, price_hash|
        total += (price_hash[:price] * price_hash[:count])
      end
    end
  else 
    cart = apply_coupons(cart, coupon)
    cart_discount = apply_clearance(cart)
    cart_discount.map do |item, price_hash|
      total += (price_hash[:price] * price_hash[:count])
    end
  end
  if total > 100
    total = total * (0.9) 
  end
total
end
