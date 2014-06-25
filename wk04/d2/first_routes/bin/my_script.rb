require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contacts.json'#, 
  # query_values: {
  #   'name' => 'Calvin',
  #   'email' => "Calvin's email"
  # }
).to_s


res =  RestClient.post(url, :contact => {'email' => 'charles@charles.com'})

