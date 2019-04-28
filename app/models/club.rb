class Club < ActiveRecord::Base
  has_many :futbolistas
  has_many :agents, through: :futbolistas
  has_many :contracts
  belongs_to :user

  validates :name, presence: true
  validates :city, presence: true
  validates :nation, presence: true
  validates :league_division, presence: true

end
