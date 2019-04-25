class Contract < ActiveRecord::Base
  belongs_to :futbolista
  belongs_to :club
  belongs_to :agent
end
