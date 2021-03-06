module Grocery
  class Order
    attr_reader :id, :products

    def initialize(id, products)
      @id = id
      @products = products
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
        csv_line = csv_file[i]
        id = csv_line[0].to_i
        product_string = csv_line[1].split(";")
        products = {}
        product_string.each do |item|
          item_array = item.split(":")
          products[item_array[0]] = item_array[1].to_f
        end
        array_of_orders << self.new(id, products)
      end
      return array_of_orders
    end

    def self.search_id(array_of_things, id_lookup)
      things_to_return = []
      array_of_things.each do |things|
        if things.id == id_lookup
          things_to_return << things
        end
      end
      return things_to_return
    end

    def self.find(csv_file,id_lookup)
      order_to_return = self.search_id(self.all(csv_file), id_lookup)
      if order_to_return.empty?
        raise ArgumentError.new "No Order with that Id #"
      end
      return order_to_return[0]
    end

  end #end of class
end #end of module
