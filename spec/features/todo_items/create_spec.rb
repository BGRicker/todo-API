require 'spec_helper'
describe "successfully creates todo items" do
  let!(:todo_list) { TodoList.create(title: "Your Cool List", description: "A good and cool list") }

  def visit_todo_list(list)
    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end
  end

  it "creates a new todo" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Pizza"
    click_button "Save"
    expect(page).to have_content("Added todo list item.")
    within("ul.todo_items") do
      expect(page).to have_content("Pizza")
    end
  end

end
