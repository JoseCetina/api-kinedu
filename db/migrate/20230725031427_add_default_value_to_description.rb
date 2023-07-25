class AddDefaultValueToDescription < ActiveRecord::Migration[6.0]
  def change
    def up
      change_column :task, :description, :text, default: ''
    end
    
    def down
      change_column :task, :description, :text, default: ''
    end
  end
end
