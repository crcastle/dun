class Accomplishment < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  has_many :comments
  has_many :likes
end
