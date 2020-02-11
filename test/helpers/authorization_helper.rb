module AuthorizationHelper
	
  def get_jwt
    post '/sesiones', params: {
      "data": {
        "type": "authentication",
        "attributes": {
          "u": "admin",
          "p": "xlAN34/aBc"
        }
      }
    }, as: :json

    #puts response.body.split(':')[1].split('"')
    #puts response.body.split('"')[3]
    response.body.split('"')[3]
  end

end