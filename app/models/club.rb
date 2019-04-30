class Club < ActiveRecord::Base
  has_many :players
  has_many :agents, through: :players
  has_many :contracts
  belongs_to :user

  validates :name, presence: true
  validates :city, presence: true
  validates :nation, presence: true
  validates :league_division, presence: true
  validates :user_id, presence: true

end
