class AddUserIdToProject < ActiveRecord::Migration
  def change
    add_column :projects, :user_id, :integer
    add_index "projects", ["user_id"], name: "index_mydocuments_on_user_id", using: :btree    
  end
end
