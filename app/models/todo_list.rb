class TodoList < ActiveRecord::Base
  validates :title, presence: true
  validates :title, length: { in: 5..30 }
  validates :description, presence: true
  validates :description, length: { in: 5..30 }

  has_many :todo_items

  def has_completed_items?
    todo_items.complete.size > 0
  end

  def has_incomplete_items?
    todo_items.incomplete.size > 0
  end
end
