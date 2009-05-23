require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :url, :periodicity, :secret_key
  should_validate_uniqueness_of :url
  should_not_allow_values_for :url, "egor@ru", "mail@mail,ru." 
  should_allow_values_for :url, "http://hashtrain.com"
  
  context "test instance method" do
    setup do
      Project.all.each do |project|
        FakeWeb.register_uri(:get, project.url, :string => '["title":"Title_2", "value":"text", "childs":[]]')
      end
    end
    
    should "collect statistics" do
      assert projects(:one).collect_statistics
      assert_not_nil projects(:one).reload.data
    end
  end
end
