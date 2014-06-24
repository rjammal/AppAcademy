require 'addressable/uri'
require 'nokogiri'
require 'rest-client'
require 'json'

api_key = nil
begin
  api_key = File.read('.api_key').chomp
rescue
  puts "Unable to read '.api_key'. Please provide a valid Google API key."
  exit
end

url_location = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "/maps/api/geocode/json",
:query_values => {:address => "1061 Market St, San Francisco, CA", 
                  :key => api_key }
).to_s

result = JSON.parse(RestClient.get(url_location))
geo = result["results"][0]["geometry"]["location"]
start_lat = geo["lat"]
start_lng = geo["lng"]

url_nearby = Addressable::URI.new(
:scheme => "https",
:host => "maps.googleapis.com",
:path => "/maps/api/place/nearbysearch/json",
:query_values => {:location => "#{start_lat},#{start_lng}", 
                  :key => api_key,
                  # :radius => 3200,
                  :sensor => false,
                  :keyword => "ice cream",
                  :rankby => "distance" }
).to_s

results_ice_cream = JSON.parse(RestClient.get(url_nearby))

results_ice_cream["results"].each do |ice_cream_shop|
  loc = ice_cream_shop["geometry"]["location"]
  end_lat = loc["lat"]
  end_lng = loc["lng"]
  name = ice_cream_shop["name"]
  
  url_directions = Addressable::URI.new(
  :scheme => "https",
  :host => "maps.googleapis.com",
  :path => "/maps/api/directions/json",
  :query_values => {:origin => "#{start_lat},#{start_lng}", 
                    :key => api_key,
                    :destination => "#{end_lat},#{end_lng}", 
                    :mode => "walking"
                  }
  ).to_s
  
  
  results_directions = JSON.parse(RestClient.get(url_directions))
  puts "#{name}, Distance = #{results_directions["routes"][0]["legs"][0]["distance"]["text"]}"
  puts "Estimated Travel Time = #{results_directions["routes"][0]["legs"][0]["duration"]["text"]}" 
  results_directions["routes"][0]["legs"][0]["steps"].each do |step|
    puts Nokogiri::HTML(step["html_instructions"]).text
  end
  print "\n" * 3
end