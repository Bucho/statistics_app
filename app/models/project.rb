class Project < ActiveRecord::Base
  validates_presence_of :title, :url, :periodicity, :secret_key
  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https))
end
