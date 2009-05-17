require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  should_validate_presence_of :title, :url, :periodicity, :secret_key
  should_validate_uniqueness_of :url
  should_not_allow_values_for :url, "egor@ru", "mail@mail,ru." 
  should_allow_values_for :url, "http://hashtrain.com"
end
