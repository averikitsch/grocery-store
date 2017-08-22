module Grocery
  class Order
    attr_reader :id, :products

    def initialize(csv_line)
      @id = csv_line[0]
      product_string = csv_line[1].split(";")
      @products = {}
      product_string.each do |item|
        item_array = item.split(":")
        @products[item_array[0]] = item_array[1].to_f
      end

    end

    def total
      total_cost = 0
      @products.each do |item,cost|
        total_cost += cost
      end
      total_cost *= 1.075
      return total_cost.round(2)
    end

    def add_product(product_name, product_price)
      if @products.keys.include?(product_name)
        return false
      else
        @products[product_name] = product_price
        return true
      end
    end

    def remove_product(product_name)
      if @products.keys.include?(product_name)
        @products.delete(product_name)
        return true
      else
        return false
      end
    end

    def self.all(csv_file)
      array_of_orders = []
      csv_file.length.times do |i|
        array_of_orders << self.new(csv_file[i])
      end
      return array_of_orders
    end

  end #end of class
end #end of module
