require 'json'
require 'webrick'

class Session
  # find the cookie for this app
  # deserialize the cookie into a hash
  def initialize(req)
    req.cookies.each do |cookie|
      if cookie.name == '_rails_lite_app'
        @cookie = JSON.parse(cookie.value)
        return
      end
    end
    @cookie = {}
    @cookie['authenticity_token'] = Session.get_auth_token
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, val)
    @cookie[key] = val
  end

  # serialize the hash into json and save in a cookie
  # add to the responses cookies
  def store_session(res)
    cookie = WEBrick::Cookie.new('_rails_lite_app', @cookie.to_json)
    res.cookies << cookie
  end


  def self.get_auth_token
    if File.exist?('secret_token.txt')
      File.read('secret_token.txt')
    else 
      auth_token = SecureRandom::urlsafe_base64
      File.open('secret_token.txt', 'w') do |f|
        f.write(auth_token)
      end
      auth_token
    end
  end
end
