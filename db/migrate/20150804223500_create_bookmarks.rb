class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.string :color
      t.belongs_to :document, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
