require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  setup :activate_authlogic 
  
  def test_new
    get :new
    assert_template 'new'
  end

  context "on POST to :create with invalid params" do
    setup do
      post :create, :user_session => {
                                 :username     => users(:one).username,
                                 :password => "bad password"
                                }
    end

    should_assign_to :user_session
    should_not_set_the_flash
    should_render_template :new
  end
  
  context "on POST to :create" do
    setup do
      post :create, :user_session => {
                                 :username     => users(:one).username,
                                 :password => 1234
                                }
    end

    should_assign_to :user_session
    should_respond_with :redirect
    should "set flash" do
      assert_not_nil flash
    end
  end
  
#  test "should destroy user session" do
#    UserSession.create(users(:one))
#    delete :destroy
#    assert_nil UserSession.find
#    assert_redirected_to new_user_session_path
#  end
end
