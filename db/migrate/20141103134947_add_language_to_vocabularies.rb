class AddLanguageToVocabularies < ActiveRecord::Migration
  def change
    add_column :vocabularies, :language, :string
  end
end
