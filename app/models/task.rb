# models/task.rb
class Task < ApplicationRecord
  validates_presence_of :title, message: 'Introduce un título.', on: [:create, :update]
  validates_uniqueness_of :title, message: 'Este título ya se encuentra registrado.'

  belongs_to :user
end
