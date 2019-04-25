class Futbolista < ActiveRecord::Base
  belongs_to :agent
  belongs_to :club
  belongs_to :contract
end
