class Contract < ActiveRecord::Base
  belongs_to :futbolista
  belongs_to :club
  belongs_to :agent

  validates :futbolista_id, presence: true
  validates :club_id, presence: true
  validates :agent_id, presence: true
  validates :status, presence: true
  validate :status_terminology

  def status_terminology
    if self.status != "in the works" && self.status != "pending" && self.status != "in effect" && self.status != "completed" && self.status != "terminated early"
      errors.add(:title, "contract status must adhere to status terminology")
    end
  end

end
