class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :accomplishment
  has_many :children, class_name: 'Comment', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Comment'

  validates_presence_of :message

  scope :ordered, -> { order("created_at ASC") }
  scope :recently_updated, -> { order("updated_at DESC")}

  def to_s
    self.message
  end
end
