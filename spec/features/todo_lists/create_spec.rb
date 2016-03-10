require 'spec_helper'

describe 'creating a todo list' do
  it 'redirects to the todo list index page on success' do
    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "My todos list"
    fill_in "Description", with: "Some cool stuff"
    click_button "Create Todo list"

    expect(page).to have_content("My todos list")
  end

  it "displays an error when the there's no title" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: ""
    fill_in "Description", with: "Some cool stuff"
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title isn't long enough" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "Test"
    fill_in "Description", with: "Some cool stuff"
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title is too long" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "Test"*50
    fill_in "Description", with: "Some cool stuff"
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end



  it "displays an error when the there's no description" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "Some cool stuff"
    fill_in "Description", with: ""
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the description isn't long enough" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "Test Title"
    fill_in "Description", with: "Test"
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end

  it "displays an error when the title is too long" do
    expect(TodoList.count).to eq(0)

    visit '/todo_lists'
    click_link 'New Todo list'
    expect(page).to have_content "New Todo List"

    fill_in "Title", with: "Test Title"
    fill_in "Description", with: "Some cool stuff"*50
    click_button "Create Todo list"

    expect(page).to have_content "error"
    expect(TodoList.count).to eq(0)

    visit "/todo_lists"
    expect(page).to_not have_content("Some cool stuff")
  end
end
