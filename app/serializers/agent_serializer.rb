class AgentSerializer < ActiveModel::Serializer
  attributes :id, :name, :country_of_origin, :user_id

  has_many :players
  has_many :clubs, through: :players
  has_many :contracts
  belongs_to :user
end
