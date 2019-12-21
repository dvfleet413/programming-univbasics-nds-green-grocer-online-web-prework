require 'pp'

def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0
  while i < collection.length do
    if collection[i][:item] == name
      return collection[i]
    else
    i += 1
    end
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  i = 0
  result = []
  while i < cart.length do
    name = cart[i][:item]
    #check if item is already in the result array
    if find_item_by_name_in_collection(name, result)
      #item is there! find index in result array and increase :count of hash
      k = 0
      while k < result.length do
        if result[k][:item] == name
          result[k][:count] += 1
          k += 1
        else
          k += 1
        end
      end
    #item is not in result array yet --> push it and add :count of 1
    else
      result << cart[i]
      result[-1][:count] = 1
    end
    i += 1
  end
  result
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #
  
  # Iterate through items in cart, check each item against the coupon array
  cart_index = 0
  while cart_index < cart.length do
    # Check if item has a coupon...
    coupon_index = 0
    while coupon_index < coupons.length do
      if (cart[cart_index][:item] == coupons[coupon_index][:item]) && (cart[cart_index][:count] >= coupons[coupon_index][:num])
        cart[cart_index][:count] -= coupons[coupon_index][:num] #Reduce count of full=price items
        discounted_item = {
          :item => "#{cart[cart_index][:item]} W/COUPON",
          :price => coupons[coupon_index][:cost] / coupons[coupon_index][:num],
          :clearance => cart[cart_index][:clearance],
          :count => coupons[coupon_index][:num]
        }
        cart << discounted_item
      end
      coupon_index += 1
    end
    cart_index += 1
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  
  # Iterate through cart and check if item is on clearance
  
  cart_index = 0
  while cart_index < cart.length do
    if cart[cart_index][:clearance] == true
      cart[cart_index][:price] = (cart[cart_index][:price]*0.8).round
    end
    cart_index += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers
  
  pp cart
  
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)
  
  total = 0
  cart_index = 0
  # Iterate through cart to total the price
  while cart_index < cart.length do
    total += cart[cart_index][:price]*cart[cart_index][:count]
    cart_index += 1
  end
  if total > 100
    total *= 0.9
  end
  pp cart
  total
end
