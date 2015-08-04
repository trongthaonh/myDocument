class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.text :content
      t.string :comment
      t.string :tag
      t.string :file
      t.belongs_to :project, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
