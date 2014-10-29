

def valid_oauth
  OmniAuth::AuthHash.new(
    { provider: 'facebook',
      uid: '123545',
      info: { email: 'email@email.com' }
    })
end

def set_mock_hash_for_facebook
  OmniAuth.config.mock_auth[:facebook] = valid_oauth
end


def set_mock_hash_for_twitter
  
  OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      provider: 'twitter',
      uid: '123545',
      info: { nickname: 'foo' }
    )
end

#TODO: for code review
def set_after_sign_in_path
  ApplicationController.class_eval do
    def after_sign_in_path_for(resource)
      questions_path
    end
  end
end