class RemoveUserIdFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :user_id
  end
end
