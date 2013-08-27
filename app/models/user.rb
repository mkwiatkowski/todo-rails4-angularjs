class User < ActiveRecord::Base
  devise :token_authenticatable, :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_one :task_list, foreign_key: :owner_id

  after_create :create_task_list

  def clear_authentication_token!
    update_attribute(:authentication_token, nil)
  end
end
