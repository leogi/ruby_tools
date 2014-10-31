class Story::Origin < Story
  has_many :translations, class_name: Story::Translation.name, foreign_key: :story_id

  after_create :assign_root_story

  private
  def assign_root_story
    self.story_id = self.id
    self.save
  end
end
