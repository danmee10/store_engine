require 'spec_helper'

describe "create" do
  context "given invalid criteria" do
    it "throws an error" do
      visit login_path
      click_button "Login"
      expect(page).to have_content "Login failed."
    end
  end
end

describe "destroy" do
  it "logs you out" do
    @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                        last_name: "garciad", password: "thisissecure")

    visit login_path
    fill_in 'login_id', with: 'dantheman@gmail.com'
    fill_in 'password', with: 'thisissecure'
    click_button 'Login'

    click_on "(logout)"
    expect(page).to have_content "Login"
  end
end

