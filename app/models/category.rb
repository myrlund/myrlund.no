class Category < ActiveRecord::Base
  attr_accessible :title, :url
  
  acts_as_url :title, sync_url: true
  
  def to_s
    title
  end
end
