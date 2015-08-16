class AddSharedWithMeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :shared_with_me, :text
  end
end
