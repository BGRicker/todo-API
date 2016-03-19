require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  it "renders the correct template" do
    get 'new'
    expect(response).to render_template('new')
  end

  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user) { User.create(first_name: "Rasheed", last_name: "Wallace", email: "rasheed@balldontlie.com", password: "refsarewrong1", password_confirmation: "refsarewrong1") }

      it "redirects to the todo list path" do
        post :create, email: "rasheed@balldontlie.com", password: "refsarewrong1"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        post :create, email: user.email
      end

      it "authenticates the user" do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "rasheed@balldontlie.com", password: "refsarewrong1"
      end

      it "sets the user_id in the session" do
        post :create, email: "rasheed@balldontlie.com", password: "refsarewrong1"
        expect(session[:user_id]).to eq(user.id)
      end

      it "congratulates the user for logging in" do
        post :create, email: "rasheed@balldontlie.com", password: "refsarewrong1"
        expect(flash[:success]).to eq("You did a good job logging in")
      end

      it "is disappointed in a user who can't log in with no info" do
        post :create
        expect(flash[:error]).to eq("This is a sad message for you")
      end

      it "is disappointed in a user who can't log in without an email" do
        post :create, password: "refsarewrong1"
        expect(flash[:error]).to eq("This is a sad message for you")
      end

      it "is disappointed in a user who can't log in without a password" do
        post :create, password: "refsarewrong1"
        expect(flash[:error]).to eq("This is a sad message for you")
      end

      context "with blank credentials" do
        it "renders the new template" do
          post :create
          expect(response).to render_template('new')
        end
      end
    end
  end
end
