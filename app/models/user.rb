# models/user.rb
class User < ApplicationRecord

  validates_uniqueness_of :email, message: 'Este email ya se encuentra registrado.'

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tasks
end
