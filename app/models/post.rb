class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :author, class_name: 'User'
  
  attr_accessible :title, :content, :published_at, :category_id
  
  acts_as_url :title, sync_url: true
  
  validates_presence_of :title
  
  scope :published, lambda { where('published_at <= ?', Time.zone.now).order('published_at DESC') }
  
  def published?
    published_at <= Time.zone.now
  end
  
  def to_s
    title
  end
  
  def to_param
    "#{id}-#{url}"
  end
  
end
