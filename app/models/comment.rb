class Comment < ActiveRecord::Base
  belongs_to :story
  belongs_to :user

  validates :content, :story, presence: true
  class << self
    def permit_attributes
      [:user_id, :content]
    end
  end
end
