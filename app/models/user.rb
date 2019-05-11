class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :password, presence: true

  def self.session_user_id(user_id)
    User.find_by_id(user_id).id
  end
end
