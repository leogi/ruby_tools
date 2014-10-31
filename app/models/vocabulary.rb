class Vocabulary < ActiveRecord::Base
  belongs_to :story

  class << self
    def permit_attributes
      [:keyword, :explain]
    end
  end
end
