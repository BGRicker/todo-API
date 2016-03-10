require 'spec_helper'

describe 'creating a todo list' do
  def create_todo_list(options={})
    options[:title] ||= "My todo list"
    options[:description] ||= "Some Cool stuff"

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: options[:title]
    fill_in "Description", with: options[:description]
    click_button "Create Todo list"
  end


  it 'redirects to the todo list index page on success' do
    create_todo_list

    expect(page).to have_content("My todo list")
  end

  it "displays an error when the there's no title" do
    expect(TodoList.count).to eq(0)
    create_todo_list title: ""

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title isn't long enough" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "sup"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title is too long" do
    expect(TodoList.count).to eq(0)

    create_todo_list title: "sup "*50

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the there's no description" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: ""

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the description isn't long enough" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: "sup"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title is too long" do
    expect(TodoList.count).to eq(0)

    create_todo_list description: "sup"*50

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end
end
