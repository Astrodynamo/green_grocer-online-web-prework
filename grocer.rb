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
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
