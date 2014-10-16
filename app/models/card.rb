class Card < ActiveRecord::Base
  validates :content, presence: true, uniqueness: true, length: { in: 4..10 }
end
