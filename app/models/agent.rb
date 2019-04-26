class Agent < ActiveRecord::Base
  has_many :futbolistas
  has_many :clubs, through: :futbolistas
  has_many :contracts

  validates :name, presence:true
end
