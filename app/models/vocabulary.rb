class Vocabulary < ActiveRecord::Base
  belongs_to :story

  LANGUAGES = Settings.languages
  validates :language, inclusion: { within: LANGUAGES }, uniqueness: { scope: [:story_id, :keyword] }
  validates :keyword, :explain, presence: true

  def to_json
    {
      id: self.id,
      language: self.language,
      keyword: self.keyword,
      explain: self.explain
    }
  end

  class << self
    def permit_attributes
      [:keyword, :explain, :language]
    end
  end
end
