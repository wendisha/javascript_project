class AgentSerializer < ActiveModel::Serializer
  attributes :id, :name, :country_of_origin, :user_id
end
