class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { minimum: 2, maximum: 300 }
end
