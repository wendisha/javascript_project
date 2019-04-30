class Agent < ActiveRecord::Base
  has_many :players
  has_many :clubs, through: :players
  has_many :contracts
  belongs_to :user


  validates :name, presence: true
  validates :user_id, presence: true
end
