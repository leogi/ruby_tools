class Vocabulary < ActiveRecord::Base
  belongs_to :story
  
  validates :keyword, :explain, presence: true
  class << self
    def permit_attributes
      [:keyword, :explain]
    end
  end
end
