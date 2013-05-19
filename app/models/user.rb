class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :accomplishments
  has_many :comments, through: :accomplishments
  has_many :likes, through: :accomplishments
  has_and_belongs_to_many :teams
end
