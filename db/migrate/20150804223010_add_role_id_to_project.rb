class AddRoleIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :role_id, :integer, references: :roles
    add_index :projects, :role_id
  end
end
