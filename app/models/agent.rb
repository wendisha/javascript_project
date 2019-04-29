class Agent < ActiveRecord::Base
  has_many :futbolistas
  has_many :clubs, through: :futbolistas
  has_many :contracts
  belongs_to :user


  validates :name, presence: true
  validates :user_id, presence: true
end
