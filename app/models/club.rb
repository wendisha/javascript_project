class Club < ActiveRecord::Base
  has_many :futbolistas
  has_many :agents, through: :futbolistas
  has_many :contracts
end
