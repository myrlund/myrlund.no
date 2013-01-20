class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :author, class_name: 'User'
  
  attr_accessible :title, :content, :published_at, :category_id, :draft
  
  acts_as_url :title, sync_url: true
  
  validates_presence_of :title
  
  scope :drafts, -> { where(draft: true) }
  scope :non_drafts, -> { where(draft: false) }
  scope :published, lambda { non_drafts.where('published_at <= ?', Time.zone.now).order('published_at DESC') }
  
  def published?
    !draft? && Time.zone.now >= published_at
  end
  
  def to_s
    title
  end
  
  def to_param
    "#{id}-#{url}"
  end
  
end
