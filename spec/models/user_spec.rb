require 'spec_helper'

describe User do
  let(:valid_attributes) {
    {
      first_name: "Kanye",
      last_name: "West",
      email: "Kanye2020@whitehouse.gov",
      password: "yourc00lpassword",
      password_confirmation: "yourc00lpassword"
    }
  }
  context "validations" do
    let(:user) { User.new(valid_attributes) }

    before do
      User.create(valid_attributes)
    end

    it "requires the user to have an email" do
      expect(user).to validate_presence_of(:email) #shoulda_matchers error
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end


    it "requires a unique email case insensitive" do
      user.email = "FUTURE@YOUNGMETRODONTTRUSTYOU.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    describe "#downcase_email" do
      it "makes the user email downcase" do
        user = User.new(valid_attributes.merge(email: "FUTURE@YOUNGMETRODONTTRUSTYOU.COM"))
        expect{ user.downcase_email }.to change{ user.email }.
          from("FUTURE@YOUNGMETRODONTTRUSTYOU.COM").
          to("future@youngmetrodonttrustyou.com")
      end
    end
  end
end
