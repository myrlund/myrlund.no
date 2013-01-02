class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :author, class_name: 'User'
  
  attr_accessible :title, :content, :category_id
  
  acts_as_url :title, sync_url: true
  
  validates_presence_of :title
  
  def tags
    [:foo, :bar, :baz]
  end
  
  def to_s
    title
  end
  
  def to_param
    "#{id}-#{url}"
  end
  
end
