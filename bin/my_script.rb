require 'addressable/uri'
require 'rest-client'

def get_index
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html'
  ).to_s

  puts RestClient.get(url)
end

def create_user(options = {})
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  puts RestClient.post(
    url,
    { user: options }
  )
end

def get_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.get(url)
end

def update_user(id, options = {})
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.patch(url, { user: options })
end

def delete_user(id)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}.json"
  ).to_s

  puts RestClient.delete(url)
end
