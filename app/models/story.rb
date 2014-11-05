class Story < ActiveRecord::Base
  has_many :vocabularies, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :vocabularies
  accepts_nested_attributes_for :comments

  LANGUAGES = Settings.languages
  validates :language, inclusion: { within: LANGUAGES }, uniqueness: {scope: [:story_id]}
  validates :title, :content, presence: true

  has_many :locale_stories, class_name: Story.name, foreign_key: :story_id
  belongs_to :origin, class_name: Story.name, foreign_key: :story_id

  scope :order_id_desc, -> { order("id DESC") }
  scope :next, ->story { where("id > ?", story.id) }
  scope :previous, ->story { where("id < ?", story.id) }
  scope :published, -> { where(state: "published") }
  scope :preview, -> { where(state: "preview") }
  state_machine initial: :preview do
    event :publish! do
      transition preview: :published
    end

    event :unpublish! do
      transition published: :preview
    end
    state :preview
    state :published
  end

  def available_languages
    self.locale_stories.published.pluck(:language)
  end

  def next relations
    relations.next(self).first
  end

  def previous relations
    relations.previous(self).last
  end

  def to_json
    {
      id: self.id,
      language: self.language,
      title: self.title,
      content: self.content
    }
  end

  def story_json
    to_json.merge!({
      translations: self.translations.map { |t| t.to_json },
      vocabularies: self.vocabularies.map { |v| v.to_json }
    })
  end

  class << self
    def permit_attributes
      [:title, :content, :language]
    end

    def create_from_json json
      ActiveRecord::Base.transaction do
        story = Story::Origin.create(language: json["language"] || json[:language],
                                    title: json["title"] || json[:title],
                                    content: json["content"] || json[:content],
                                     state: "published")

        (json["translations"] || json[:translations]).each do |trans|
          story.translations.create(language: trans["language"] || trans[:language], title: trans["title"] || trans[:title],
                                    content: trans["content"] || trans[:content], state: "published")
        end
        (json["vocabularies"] || json[:vocabularies]).each do |voca|
          story.vocabularies.create(language: voca["language"] || voca[:language], keyword: voca["keyword"] || voca[:keyword],
                                    explain: voca["explain"] || voca[:explain])
        end
      end
    end
  end
end
