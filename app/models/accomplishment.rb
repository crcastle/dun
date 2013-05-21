class Accomplishment < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  sync :all, scope: :team

  def like_for user
    likes.find_by(user: user)
  end
end
