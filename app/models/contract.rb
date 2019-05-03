class Contract < ActiveRecord::Base
  belongs_to :player
  belongs_to :club
  belongs_to :agent
  belongs_to :user

  validates :player_id, presence: true
  validates :club_id, presence: true
  validates :agent_id, presence: true
  validates :status, presence: true
  validate :status_terminology
  validates :user_id, presence: true

  scope :in_effect, -> { where(status: "in effect") }

  def status_terminology
    if self.status != "in the works" && self.status != "pending" && self.status != "in effect" && self.status != "completed" && self.status != "terminated early" && self.status != "dead"
      errors.add(:title, "contract status must adhere to status terminology")
    end
  end

end
