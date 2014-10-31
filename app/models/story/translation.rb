class Story::Translation < Story
  belongs_to :story, class_name: Story::Origin.name
end
