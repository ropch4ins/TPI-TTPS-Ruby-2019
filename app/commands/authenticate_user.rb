# https://gist.github.com/jonbarlo/17f911ac49ed9eea55febe544916e210
class AuthenticateUser
  prepend SimpleCommand

  def initialize(username, password)
    @username = username
    @password = password
  end

  def call
    user = User.find_by_username(@username)
    if user && user.authenticate(@password)
      plain_token = JsonWebToken.encode(user_id: user.id)
      user.temp_token = Digest::SHA256.hexdigest(plain_token)
      user.save
      plain_token
    else
      errors.add :user_authentication, 'Credenciales invalidas'
      nil
    end
  end
end