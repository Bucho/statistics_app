require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic # run before tests are executed
  
  #INDEX
  context "on GET to :index" do
      setup do
        get :index
      end
  
      should_respond_with :redirect
    end

  #SHOW
  context "on GET to :show" do
    setup do
      get :show, :id => users(:one).username
    end
  
    should_respond_with :redirect
  end
    
  #NEW
  context "on GET to :new" do
    setup do
        get :new
      end
  
      should_respond_with :redirect
    end
  
  #CREATE
  context "on POST to :create" do
    setup do
      post :create, :user => {
                                 :username => "qwer",
                                 :email => "qweq@mail.ru",
                                 :password => 1234,
                                 :password_confirmation => 1234
                                }
    end

    should_respond_with :redirect
  end

  context "on POST to :create with invalid params" do
    setup do
      post :create, :user_session => {
                                 :username => "qwer",
                                 :email => "qweq@mail.ru.",
                                 :password => 1234,
                                 :password_confirmation => 2345
                                }
    end

    should_respond_with :redirect
  end  
  
  #EDIT
  context "on GET to :edit" do
    setup do
      UserSession.create(users(:one))
      get :edit, :id => "bla"
    end

    should_assign_to :user
  end
  
  #UPDATE
  context "on PUT to :update" do
    setup do
      UserSession.create(users(:one))
      put :update, :id => "fake id", :user => { :username => "Vasya" }
    end
  
    should_assign_to :user
    should_respond_with :redirect
    should "set flash" do
      assert !flash.blank?
    end
  end
    
  context "on PUT to :update with not walid param" do
    setup do
      UserSession.create(users(:one))
      put :update, :id => "fake id", :user => {:username => nil}
    end
  
    should_assign_to :user
    should_respond_with :success
    should_render_template :edit
    should_not_set_the_flash
  end  

  #DESTROY
  context "on DELETE to :destroy" do
    setup do
      UserSession.create(users(:one))
      delete :destroy, :id => "fake id"
    end
    
    should_change "User.count", :by => -1
    should_assign_to :user
    should_respond_with :redirect
    should_not_set_the_flash
  end
end
