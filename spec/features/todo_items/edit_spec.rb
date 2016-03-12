require 'spec_helper'

describe "editing todo items" do
  let!(:todo_list) { TodoList.create(title: "Your Cool List", description: "A good and cool list") }
  let!(:todo_item) { todo_list.todo_items.create(content: "get a pizza") }

  it "edits a todo list with valid info" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "dont forget pizza"
    click_button "Save"
    expect(page).to have_content("Added todo list item.")
    todo_item.reload
    expect(todo_item.content).to eq("dont forget pizza")
  end

  it "fails an edit with no content" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: ""
    click_button "Save"
    expect(page).to have_content("There was a problem adding that todo list item")
    expect(page).not_to have_content("Saved todo list item")
    todo_item.reload
    expect(todo_item.content).to eq("get a pizza")
  end

  it "fails an edit with content thats too long" do
    visit_todo_list(todo_list)
    within("#todo_item_#{todo_item.id}") do
      click_link "Edit"
    end
    fill_in "Content", with: "this is long"*10
    click_button "Save"
    expect(page).to have_content("There was a problem adding that todo list item")
    expect(page).not_to have_content("Saved todo list item")
    todo_item.reload
    expect(todo_item.content).to eq("get a pizza")
  end

end
