class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :content
      t.string :language
      t.string :title
      t.string :type
      t.integer :story_id

      t.timestamps
    end
  end
end
