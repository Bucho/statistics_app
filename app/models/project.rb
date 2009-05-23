class Project < ActiveRecord::Base
  validates_presence_of :title, :url, :periodicity, :secret_key
  validates_uniqueness_of :url
  validates_format_of :url, :with => URI::regexp(%w(http https))
  
  def collect_statistics
    if Time.now > (self.updated_at + periodicity.minutes)
      content = Net::HTTP.get(URI.parse("#{self.url}?secret_key=#{self.secret_key}"))
      self.data = content
      self.save
    end
  end
end
