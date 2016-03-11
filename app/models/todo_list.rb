class TodoList < ActiveRecord::Base
  validates :title, presence: true
  validates :title, length: { in: 5..30 }
  validates :description, presence: true
  validates :description, length: { in: 5..30 }

  has_many :todo_items
end
