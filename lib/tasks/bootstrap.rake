desc 'Create default user admin'

namespace :statistics_app do
  task :create_default_user => :environment do
    User.delete_all
    user = User.new
    user.username = "admin"
    user.email = "mail@hashtrain.com"
    user.password = "admin"
    user.password_confirmation = "admin"
    user.save
  end
end
