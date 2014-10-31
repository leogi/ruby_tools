class Story < ActiveRecord::Base
  has_many :vocabularies
  has_many :comments

  accepts_nested_attributes_for :vocabularies
  accepts_nested_attributes_for :comments

  LANGUAGES = %w(English Vietnamese Japanese)
  validates :language, inclusion: { within: LANGUAGES }, uniqueness: {scope: [:story_id]}
  validates :title, :content, presence: true

  has_many :locale_stories, class_name: Story.name, foreign_key: :story_id
  belongs_to :origin, class_name: Story.name, foreign_key: :story_id

  def available_languages
    self.locale_stories.pluck(:language)
  end

  class << self
    def permit_attributes
      [:title, :content, :language]
    end
  end
end
