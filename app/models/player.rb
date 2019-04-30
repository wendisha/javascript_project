class Player < ActiveRecord::Base
  belongs_to :agent
  belongs_to :club
  belongs_to :contract
  belongs_to :user

  # validate :contract_status_accurate
  validates :user_id, presence: true
  validates :name, presence: true

  # scope :belonging_to_player, => { where(player: self) }
  # scope :belonging_to_player_and_in_effect, => { belonging_to_player.where(status: "in effect") }
  #
  # def contract_status_accurate
  #   if self.contract.status != "in effect" || if Contract.belonging_to_player_and_in_effect.count > 1
  #     errors.add(:title, "for this player, the contract statuses are inaccurate. each player must have at most one contract that is in effect, and if they have one it must correspond to the contract that that player belongs to")
  #   end
  # end

end
