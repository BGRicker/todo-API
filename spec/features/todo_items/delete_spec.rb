require 'spec_helper'

describe "deletes todo items" do
  let!(:todo_list) { TodoList.create(title: "Your Cool List", description: "A good and cool list") }
  let!(:todo_item) { todo_list.todo_items.create(content: "get a pizza") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "is successful" do
    visit_todo_list(todo_list)
    within "#todo_item_#{todo_item.id}" do
      click_link "Destroy"
    end
    expect(page).to have_content("Todo list item was deleted.")
    expect(TodoItem.count).to eq(0)
  end
end
