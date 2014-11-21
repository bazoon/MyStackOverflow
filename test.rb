require "oauth2"


app_id = "261326f59d011032521e0b4a89e168e67a272db3560c85c0f2e3cf37f3d1ce72"
secret = "3fb6160170a86b0673f8164833b4fea7c1fcc96cd1972b9b76315da615574185"
callback_url = 'urn:ietf:wg:oauth:2.0:oob'

client = OAuth2::Client.new(app_id, secret, :site => 'http://localhost:3000')
client.auth_code.authorize_url(:redirect_uri => callback_url)
token = client.auth_code.get_token('014127cd6032091d2a92ca085cf801d8e4956cfaac519a48e51d22834be96673', :redirect_uri => callback_url)

p token

