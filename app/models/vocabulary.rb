class Vocabulary < ActiveRecord::Base
  belongs_to :story

  LANGUAGES = Settings.languages
  validates :language, inclusion: { within: LANGUAGES }, uniqueness: { scope: [:story_id] }
  validates :keyword, :explain, presence: true
  class << self
    def permit_attributes
      [:keyword, :explain, :language]
    end
  end
end
