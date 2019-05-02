class Player < ActiveRecord::Base
  belongs_to :agent
  belongs_to :club
  # belongs_to :contract
  belongs_to :user
  has_many :contracts

  validates :user_id, presence: true
  validates :name, presence: true
  validate :contract_status_accurate?

  def contract_status_accurate?
    if !self.contracts.nil?
      if self.contracts.where(status: "in effect").count > 1
        errors.add(:title, "for this player, the contract statuses are inaccurate. each player must have at most one contract that is in effect")
      end
    end
  end

end
