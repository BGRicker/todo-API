require 'spec_helper'

describe "Viewing todo items" do
  let!(:todo_list) { TodoList.create(title: "Your Cool List", description: "A good and cool list") }

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    expect(page).to have_content(todo_list.title)
  end

  it "displays no items when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items tbody tr").size).to eq(0)
  end

  it "displays items when a todo list has items" do
    todo_list.todo_items.create(content: "That's a spicy meatball")
    visit_todo_list(todo_list)
    expect(page.all("table.todo_items tbody tr").size).to eq(1)
    expect(page).to have_content("That's a spicy meatball")
  end
end
