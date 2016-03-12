require 'spec_helper'

describe TodoItem do
  describe "#completed?" do

    let(:todo_item) { TodoItem.create(content: "Hello") }

    it "is false when completed_is blank" do
      todo_item.completed_at = nil
      expect(todo_item.completed?).to be_false
    end

    it "is true when completed_is valid" do
      todo_item.completed_at = Time.now
      expect(todo_item.completed?).to be_true
    end
  end
end
