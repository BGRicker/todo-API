require 'spec_helper'
describe "successfully creates todo items" do
  let!(:todo_list) { TodoList.create(title: "Your Cool List", description: "A good and cool list") }

  def create_todo_item(options={})
    options[:content] ||= "A good piece of content"

    visit "/todo_lists"
    within "#todo_list_#{list.id}" do
      click_link "List Items"
    end

    fill_in "Content", with: "Pizza"
    click_button "Save"
  end

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

  it "won't create a todo without content" do
    create_todo_list title: ""
    expect(page).to have_content("There was a problem adding that todo list item.")
  end

  it "won't create a todo with a short content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Ox"
    click_button "Save"
    expect(page).to have_content("There was a problem adding that todo list item.")
  end

  it "won't create a todo with a long content" do
    visit_todo_list(todo_list)
    click_link "New Todo Item"
    fill_in "Content", with: "Ox"*50
    click_button "Save"
    expect(page).to have_content("There was a problem adding that todo list item.")
  end

end
