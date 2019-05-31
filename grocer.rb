def consolidate_cart(cart)
  cart.each_with_object({}) do |item, result|
    item.each do |type, attributes|
      if result[type]
        attributes[:count] += 1
      else
        attributes[:count] = 1
        result[type] = attributes
      end
    end
  end
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
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
