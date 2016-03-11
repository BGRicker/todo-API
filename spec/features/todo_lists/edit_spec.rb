require 'spec_helper'

describe "Editing todo lists" do
  let!(:todo_list) {TodoList.create(title: "Groceries", description: "Grocery list")}
  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "Some Cool stuff"

    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end 

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Update Todo list"
  end

  it "updates todo list successfully" do
    update_todo_list todo_list: todo_list,
      title: "Your cool new title",
      description: "Your cool new description"

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated.")
    expect(todo_list.title).to eq("Your cool new title")
    expect(todo_list.description).to eq("Your cool new description") 
  end

  it "displays an error when updating with no title" do
    update_todo_list todo_list: todo_list, title: ""
    expect(page).to have_content("error")
  end

  it "displays an error when updating with no description" do
    update_todo_list todo_list: todo_list, description: ""
    expect(page).to have_content("error")
  end

  it "displays an error when updating with a short title" do
    update_todo_list todo_list: todo_list, title: "sup"
    expect(page).to have_content("error")
  end

  it "displays an error when updating with a short description" do
    update_todo_list todo_list: todo_list, description: "sup"
    expect(page).to have_content("error")
  end

  it "displays an error when updating with a long title" do
    update_todo_list todo_list: todo_list, title: "sup"*50
    expect(page).to have_content("error")
  end

  it "displays an error when updating with a long description" do
    update_todo_list todo_list: todo_list, description: "sup"*50
    expect(page).to have_content("error")
  end
end
