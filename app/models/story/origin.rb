class Story::Origin < Story
  has_many :translations, class_name: Story::Translation.name, foreign_key: :story_id
end
