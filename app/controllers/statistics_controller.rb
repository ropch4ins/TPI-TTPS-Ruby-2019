class StatisticsController < PrivateController
	before_action :get_sells, only: [:top_ventas]
	before_action :get_users, only: [:usuarios_mas_ventas]


	def top_ventas
		top_sells = @sells.sort_by { | sell | total_price(sell) }
		top_sells = top_sells.reverse
		first_10 = top_sells.first(10)
		render jsonapi: first_10
	end

	def usuarios_mas_ventas
		usuarios_mas_ventas = @users.sort_by { | user | ventas_totales(user) }
		usuarios_mas_ventas = usuarios_mas_ventas.reverse
		first_10 = usuarios_mas_ventas.first(10)
		render jsonapi: first_10
	end


    private

		def total_price(sell)
			item_sells = ItemSell.where(sell_id: sell)
			item_sells.map(&:price).inject(:+)
		end

		def ventas_totales(user)
			total_sells = Sell.where(user_id: user)
			total_sells.length
		end

		def get_sells
			@sells = Sell.all
		end

		def get_users
			@users = User.all
		end
end