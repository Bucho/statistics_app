require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def test_new
    get :new
    assert_template 'new'
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

    should_assign_to :user
    should_respond_with :redirect
    should "set flash" do
      assert_not_nil flash
    end
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

    should_assign_to :user
    should_not_set_the_flash
    should_render_template :new
  end  
  
  #TODO fix this test (Egor)
#  def test_edit
#    get :edit, :id => User.first.id 
#    assert_template 'edit'
#  end
  
  #TODO fix user authentication (Egor)
#  def test_update_invalid
#    User.any_instance.stubs(:valid?).returns(false)
#    put :update, :id => User.first
#    assert_template 'edit'
#  end

#  def test_update_valid
#    User.any_instance.stubs(:valid?).returns(true)
#    put :update, :id => User.first
#    assert_redirected_to root_url
#  end
end
