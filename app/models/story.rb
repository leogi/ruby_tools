class Story < ActiveRecord::Base
  has_many :vocabularies
  has_many :comments

  accepts_nested_attributes_for :vocabularies
  accepts_nested_attributes_for :comments

  LANGUAGES = Settings.languages
  validates :language, inclusion: { within: LANGUAGES }, uniqueness: {scope: [:story_id]}
  validates :title, :content, presence: true

  has_many :locale_stories, class_name: Story.name, foreign_key: :story_id
  belongs_to :origin, class_name: Story.name, foreign_key: :story_id

  scope :order_created_at_desc, -> { order("created_at DESC") }
  scope :next, ->story { order_created_at_desc.where("created_at <= ? AND id <> ?", story.created_at, story.id) }
  scope :previous, ->story { order_created_at_desc.where("created_at >= ? AND id <> ?", story.created_at, story.id) }

  def available_languages
    self.locale_stories.pluck(:language)
  end

  def next relations
    relations.next(self).first
  end

  def previous relations
    relations.previous(self).last
  end

  class << self
    def permit_attributes
      [:title, :content, :language]
    end
  end
end
