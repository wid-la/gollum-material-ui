require 'net/http'
require 'uri'
require 'base64'
require 'json'

def get_styx_payload(styx_url, token, redirect_url, service_name)
  uri = URI.parse(styx_url + '/sessionmanagement/sessions/' + token)
  http = Net::HTTP.new(uri.host, uri.port)

  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)

  puts "______ STYX _______"
  puts response
  puts response.code

  if token.nil? && !redirect_url.nil?
    return -1, ""
  end
    
  if response.code == '403' && !redirect_url.nil?
    puts "Redirect !!"
    return -1, ""
  end

  hash    = JSON.parse(response.body)

  if !hash["policies"].include? service_name
    puts "Redirect !!"
    return -1, ""
  end

  return decode_tas_payload(hash["payload"])
end

def decode_tas_payload(payload)
  puts "DECODING"
  return -1, "" if payload.nil?
  plain   = Base64.decode64(payload)
  hash    = JSON.parse(plain)
  first   = hash["user"]["firstName"]
  last    = hash["user"]["lastName"]
  email   = hash["user"]["email"]
  author =  { :name => "#{first} #{last}", :email => email }
  return nil, author
end
