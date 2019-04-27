class Agent < ActiveRecord::Base
  has_many :futbolistas
  has_many :clubs, through: :futbolistas
  has_many :contracts

  accepts_nested_attributes_for :futbolista

  validates :name, presence: true
end
