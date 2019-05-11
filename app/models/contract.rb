class Contract < ActiveRecord::Base
  belongs_to :player
  belongs_to :club
  belongs_to :agent
  belongs_to :user

  validates :status, presence: true
  validate :status_terminology
  validate :contract_status_accurate?

  scope :in_effect, -> { where(status: "in effect") }

  def status_terminology
    if self.status != "in the works" && self.status != "pending" && self.status != "in effect" && self.status != "completed" && self.status != "terminated early" && self.status != "dead"
      errors.add(:contract, "Each contract status must adhere to status terminology")
    end
  end

  def contract_status_accurate?
    if Contract.in_effect.find_by(player: self.player) != self && self.status == "in effect"
      errors.add(:contract, "This contract would cause its player's contract statuses to be inaccurate. Each player must have at most one contract that is in effect at a time")
    end
  end

end
