class SerializableSell < JSONAPI::Serializable::Resource
    type 'sells'

    has_many :sell_details do
      data do
        @object.sell_details
      end
    end

    attribute :date

    attribute :client_denomination do
        @object.client.denomination
    end

    attribute :total_price do
        item_sells = ItemSell.where(sell_id: @object)
        item_sells.map(&:price).inject(:+)
        #item_sells[1][:price]
        #item_sells.inject { |total, item| total + item[:price] }
        #item_sells.inject { |total, item| total + item.price }
    end

    #attribute :total_price do
    #    @object.sell_details.collect{ |sd| sd.product.price * sd.quantity}.inject :+
    #end

    # belongs_to :reservation
end
