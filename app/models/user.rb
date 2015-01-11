class User < ActiveRecord::Base
  has_one :list

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
