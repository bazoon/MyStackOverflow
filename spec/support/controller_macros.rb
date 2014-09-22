module ControllerMacros
  
  def sign_in_user
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @user ||= FactoryGirl.create(:user)
      sign_in @user
    end
  end
  
  def expect_to_delete(object, params)
    object
    expect { delete :destroy, params }.to change(object.class, :count).by(-1)
  end

  def expect_to_not_delete(object, params)
    object
    expect { delete :destroy, params }.to change(object.class, :count).by(0)
  end

  def expect_to_not_create(params, klass)
    expect { post :create, params }.to change(klass, :count).by(0)
  end

  def expect_to_create(params, klass)
    expect { post :create, params }.to change(klass, :count).by(1)
  end

      
  def expect_after_action_redirect_to(path)
    yield
    expect(response).to redirect_to path
  end

end
