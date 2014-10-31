class Story < ActiveRecord::Base
  has_many :vocabularies
  has_many :comments

  accepts_nested_attributes_for :vocabularies
  accepts_nested_attributes_for :comments

  class << self
    def permit_attributes
      [:title, :content, :language]
    end
  end
end
