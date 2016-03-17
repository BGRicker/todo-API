require 'spec_helper'

describe "signing up" do
  it "allows a user to sign up for the site" do
    expect(User.count).to eq(0)

    visit "/"
    expect(page).to have_content("Sign Up")
    click_link "Sign Up"

    fill_in "First name", with: "Wayne"
    fill_in "Last name", with: "Carter"
    fill_in "Email", with: "Cool@okaybud.com"
    fill_in "Password", with: "AwesomePassword"
    fill_in "Password (again)", with: "AwesomePassword"
    click_button "Sign Up"

    expect(User.count).to eq(1)
  end
end
