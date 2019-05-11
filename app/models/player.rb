class Player < ActiveRecord::Base
  belongs_to :agent
  belongs_to :club
  # belongs_to :contract
  belongs_to :user
  has_many :contracts

  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :user_id

end
