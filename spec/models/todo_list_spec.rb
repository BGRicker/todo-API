require 'spec_helper'

describe TodoList do

  describe "#has_complete_items?" do
    let(:todo_list) { TodoList.create(title: "The best possible list", description: "Things to do for fun") }

    it "returns true with completed todo list items" do
      todo_list.todo_items.create(content: "Get the new Kanye album", completed_at: 1.minute.ago)
      expect(todo_list.has_completed_items?).to be_truthy
    end

    it "returns false with no completed todo list items" do
      todo_list.todo_items.create(content: "Get the new Kanye album")
      expect(todo_list.has_completed_items?).to be_falsey
    end
  end

  describe "#has_incomplete_items?" do
    let(:todo_list) { TodoList.create(title: "Groceries", description: "Grocery list") }

    it "returns true with incompleted todo list items" do
      todo_list.todo_items.create(content: "Eggs")
      expect(todo_list.has_incomplete_items?).to be_truthy
    end

    it "returns false with no incomplete todo list items" do
      todo_list.todo_items.create(content: "Eggs", completed_at: 1.minute.ago)
      expect(todo_list.has_incomplete_items?).to be_falsey
    end
  end
end
