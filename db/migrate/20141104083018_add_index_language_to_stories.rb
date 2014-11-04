class AddIndexLanguageToStories < ActiveRecord::Migration
  def change
    add_index :stories, :language
    add_index :vocabularies, :language
  end
end
