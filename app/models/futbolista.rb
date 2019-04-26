class Futbolista < ActiveRecord::Base
  belongs_to :agent
  belongs_to :club
  belongs_to :contract

  validates :contract_id, presence: true
  validates :club_id, presence: true
  validates :agent_id, presence: true
  validate :contract_status_accurate

  scope :belonging_to_futbolista, => { where(futbolista: self) }
  scope :belonging_to_futbolista_and_in_effect, => { belonging_to_futbolista.where(status: "in effect") }

  def contract_status_accurate
    if self.contract.status != "in effect" || if Contract.belonging_to_futbolista_and_in_effect.count > 1
      errors.add(:title, "for this player, the contract statuses are inaccurate. each player must have one and only one contract that is in effect, and it must correspond to the contract that that player belongs to")
    end
  end

end
