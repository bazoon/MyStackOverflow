
def set_mock_hash_for_facebook
  
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '123545',
      info: {
        email: 'email@email.com'
      }

    )
end


def set_mock_hash_for_twitter
  
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123545',
      info: { nickname: 'foo' }
    )
end
