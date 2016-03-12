class TodoItem < ActiveRecord::Base
  belongs_to :todo_list
  validates :content, presence: true
  validates :content, length: { in: 3..30 }

  def completed?
    !completed_at.blank?
  end
end
