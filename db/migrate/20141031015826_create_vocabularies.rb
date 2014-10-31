class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :keyword
      t.text :explain
      t.integer :story_id

      t.timestamps
    end
  end
end
