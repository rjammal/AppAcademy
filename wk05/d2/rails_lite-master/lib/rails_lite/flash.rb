require 'webrick'
require 'json'

class Flash

  def initialize(req)
    req.cookies.each do |cookie|
      if cookie.name == "_flash"
        @cookie = JSON.parse(cookie)
        return
      end
    end
    @cookie = {}
  end

  def [](key)
    @cookie[key]
  end

  def []=(key, value)
    @cookie[key] = value
  end

  def store_session(res)
    cookie = WEBrick::Cookie.new(@cookie.to_json)
    res.cookies << cookie
  end
end