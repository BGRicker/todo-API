require 'spec_helper'

describe "deleting todo lists" do
  let!(:todo_list) {TodoList.create(title: "Destroy your todo app", description: "todo apps aren't interesting")}

  it "is successful when clicking delete link" do
    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Destroy"
    end
    expect(page).to_not have_content(todo_list.title)
    expect(TodoList.count).to eq(0)
    expect(page).to have_content("Todo list was successfully destroyed.")
  end
end
