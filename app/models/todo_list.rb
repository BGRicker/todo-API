class TodoList < ActiveRecord::Base
  validates :title, presence: true
  validates :title, length: { in: 5..30 }
end