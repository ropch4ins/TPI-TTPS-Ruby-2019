class CreateUserRequest
  include ActiveModel::Validations

  attr_reader :password

  PASSWORD_FORMAT = /\A
    (?=.{8,})          # Must contain 8 or more characters
    (?=.*\d)           # Must contain a digit
    (?=.*[a-z])        # Must contain a lower case character
    (?=.*[A-Z])        # Must contain an upper case character
    (?=.*[[:^alnum:]]) # Must contain a symbol
  /x

  validates :password, format: { with: PASSWORD_FORMAT, message: "debe tener un mínimo de 8 caracteres, un digito numérico, una letra en minúscula, una letra en mayúscula y un símbolo" }

  def initialize(hash)
    @password = hash[:password]
  end

end