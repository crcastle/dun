class Team < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :users
  has_many :accomplishments
  has_and_belongs_to_many :users
end
