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
        @object.total_price
        #item_sells = ItemSell.where(sell_id: @object)
        #item_sells.map(&:price).inject(:+)
    end

end