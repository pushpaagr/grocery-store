require_relative 'customer'

class Order

  attr_reader :id
  attr_accessor :products, :customer, :fulfillment_status

  def initialize(id, products, customer, fulfillment_status = :pending)
    @id = id
    @products = products
    @customer = customer
    @fulfillment_status = fulfillment_status

    valid_statuses = %i[pending paid processing shipped complete]

    unless valid_statuses.include?(fulfillment_status) then
      raise ArgumentError, "wrong status entered"
    end

  end


  def total
    total_without_tax = 0
    total_with_tax = 0
    @products.each do |product, price|
      total_without_tax = total_without_tax + price
      total_with_tax = (total_without_tax * 0.075) + total_without_tax
    end
    return total_with_tax.round(2)
  end

  def add_product(product, price)

    if @products[product]
      raise ArgumentError, "product already entered"
    else
      @products[product] = price
    end
  end
end
