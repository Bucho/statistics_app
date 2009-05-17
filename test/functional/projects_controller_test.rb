require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup :activate_authlogic # run before tests are executed
  
  should_route :get,    'projects',         :controller => 'projects', :action => :index
  should_route :get,    'projects/new',     :controller => 'projects', :action => :new
  should_route :get,    'projects/1',       :controller => 'projects', :action => :show,     :id => 1
  should_route :get,    'projects/1/edit',  :controller => 'projects', :action => :edit,     :id => 1
  should_route :post,   'projects',         :controller => 'projects', :action => :create
  should_route :put,    'projects/1',       :controller => 'projects', :action => :update,   :id => 1
  should_route :delete, 'projects/1',       :controller => 'projects', :action => :destroy,  :id => 1

  should_require_login_in :get, :edit
  should_require_login_in :put, :update
  should_require_login_in :delete, :destroy
  should_require_login_in :get, :index
  should_require_login_in :get, :show
  should_require_login_in :get, :new
  should_require_login_in :post, :create

  context "with authorized user" do
    setup do
      UserSession.create(users(:one))  
    end
  
    #INDEX
    context "on GET to :index" do
      setup do
        get :index
      end
  
      should_assign_to :projects
      should_respond_with :success
      should_render_template :index
      should_not_set_the_flash
    end
    
    #SHOW
    context "on GET to :show" do
      setup do
        get :show, :id => projects(:one).id
      end
  
      should_assign_to :project
      should_respond_with :success
      should_render_template :show
      should_not_set_the_flash
    end
    
    #NEW
    context "on GET to :new" do
      setup do
        get :new
      end
  
      should_assign_to :project
      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash
    end
    
    #CREATE
    context "on POST to :create" do
      setup do
        post :create, :project => {
                                    :title => "rubyflow",
                                    :url => "http://rubyflow.ru",
                                    :periodicity => 30,
                                    :secret_key => "fdhgjksdfhgkjhslhjh85y45hjrktghlfdjkhg745jh"
                                  }
      end
  
      should_change "Project.count", :by => 1
      should_assign_to :project
      should_respond_with :redirect
    end
    
    context "on POST to :create with not walid param" do
      setup do
        post :create, :project => {
                                    :title => nil,
                                    :url => "http://rubyflow"
                                  }
      end
  
      should_assign_to :project
      should_respond_with :success
      should_render_template :new
    end
    
    #EDIT
    context "on GET to :edit" do
      setup do
        get :edit, :id => projects(:one).id
      end
  
      should_assign_to :project
      should_respond_with :success
      should_render_template :edit
      should_not_set_the_flash
    end
    
    #UPDATE
    context "on PUT to :update" do
      setup do
        put :update, :id => projects(:one).id, :project => { :periodicity => 30 }
      end
  
      should_assign_to :project
      should_respond_with :redirect
      should "set flash" do
        assert !flash.blank?
      end
    end
    
    context "on PUT to :update with not walid param" do
      setup do
        put :update, :id => projects(:one).id, :project => {:title => nil}
      end
  
      should_assign_to :project
      should_respond_with :success
      should_render_template :edit
    end
    
    #DESTROY
    context "on DELETE to :destroy" do
      setup do
        delete :destroy, :id => projects(:one).id
      end
      
      should_change "Project.count", :by => -1
      should_assign_to :project
      should_respond_with :redirect
      should_not_set_the_flash
    end
  end
end
