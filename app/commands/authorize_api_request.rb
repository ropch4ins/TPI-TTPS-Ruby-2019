class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user_id = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    plain_token = http_auth_header
    encrypted_token = Digest::SHA256.hexdigest(plain_token)
    @user ||= User.find_by({id:user_id,temp_token:encrypted_token})
    @user || errors.add(:token, 'Invalid token') && nil
  end

  private

  attr_reader :headers

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end
