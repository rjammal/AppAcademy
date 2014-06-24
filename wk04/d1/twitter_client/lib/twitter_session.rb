class TwitterSession
  TOKEN_FILE = "access_token.yml"
  def self.access_token
    if File.exist?(TOKEN_FILE)
      File.open(TOKEN_FILE) { |f| YAML.load(f) }
    else
      access_token = request_access_token
      File.open(TOKEN_FILE, "w") { |f| YAML.dump(access_token, f) }
      access_token
    end
  end
  
  def self.request_access_token
    consumer_key = File.read(Rails.root.join(".api_key")).chomp
    consumer_secret = File.read(Rails.root.join(".api_key_secret")).chomp
    
    consumer = OAuth::Consumer.new(
      consumer_key, consumer_secret, :site => "https://twitter.com"
    )
    
    request_token = consumer.get_request_token
    authorize_url = request_token.authorize_url
    
    puts "Go to this URL: #{authorize_url}"
    Launchy.open(authorize_url)
    
    puts "Login, and type your verification code in"
    oauth_verifier = Integer(gets.chomp)
    request_token.get_access_token(
      :oauth_verifier => oauth_verifier
    )
  end
  
  def self.path_to_url(path, query_values = nil)
    url = Addressable::URI.new(
      scheme: "https", 
      host: "api.twitter.com", 
      path: "1.1/#{path}.json", 
      query_values: query_values
    ).to_s
    puts url
    url
  end
  
  def self.get(path, query_values = nil)
    access_token.get(path_to_url(path, query_values)).body
  end
  
  def self.post(path, query_values = nil)
    access_token.post(path_to_url(path, query_values))
  end
  
end