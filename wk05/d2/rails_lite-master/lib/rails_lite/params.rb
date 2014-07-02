require 'uri'
require 'debugger'

class Params
  # use your initialize to merge params from
  # 1. query string
  # 2. post body
  # 3. route params
  def initialize(req, route_params = {})
    @params = route_params
    @permitted = []

    return if !req

    if req.query_string
      parse_www_encoded_form(req.query_string)
    end
    if req.body
      parse_www_encoded_form(req.body)
    end
  end

  def [](key)
    @params[key]
  end

  def permit(*keys)
    @permitted += keys
  end

  def require(key)
    raise AttributeNotFoundError if @params[key].nil?
    @params[key]
  end

  def permitted?(key)
    @permitted.include?(key)
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private
  # this should return deeply nested hash
  # argument format
  # user[address][street]=main&user[address][zip]=89436
  # should return
  # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
  def parse_www_encoded_form(www_encoded_form)
    param_array = URI.decode_www_form(www_encoded_form)
    param_array.each do |pair|
      raw_key = pair[0]
      value = pair[1]
      keys = parse_key(raw_key)
      current_hash = @params
      keys.each_with_index do |k, i|
        if i == keys.length - 1
          current_hash[k] = value
        else
          current_hash[k] ||= {}
          current_hash = current_hash[k]
        end
      end
    end
  end

  # this should return an array
  # user[address][street] should return ['user', 'address', 'street']
  def parse_key(key)
    if key == ""
      []
    elsif key[0] != "["
      # grab first key, parse rest
      parse = key.scan(/([^\[]+)(.*)/)
      [parse[0][0]] + parse_key(parse[0][1])
    else # remove initial brackets if first key kas brackets
      key = key.sub('[', '')
      key = key.sub(']', '')
      parse_key(key)
    end
  end

end
