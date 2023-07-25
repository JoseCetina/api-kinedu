class TaskSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at, :title, :description, :user

  def id
    self.object.id.to_s
  end

  def created_at
    self.object.created_at.in_time_zone('Mexico City').strftime('%d-%m-%Y')
  end

  def user
    name = User.find(self.object.user_id).email
  end

end
