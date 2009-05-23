desc 'Collecting statistics from external urls'

namespace :statistics_app do
  task :collect_statistics => :environment do
    Project.all.each do |p|
      p.collect_statistics
    end
  end
end
