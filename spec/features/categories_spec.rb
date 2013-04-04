require 'spec_helper'

describe 'Categories Page' do

  context "as logged in admin" do
    before(:each) do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure", admin: true)

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'
    end

    it "has an admin page" do
      visit categories_path
      expect(page).to have_content "Listing categories"
    end

    context "given a category name that does not already exist" do
      it "allows an admin to create a new category" do
        visit categories_path
        click_on "New Category"
        fill_in "category_name", with: "dog"
        click_on "Create Category"
        expect(page).to have_content "dog"
      end

      context "given a category name which already exists" do
        it "flashes an error" do
          visit categories_path
          click_on "New Category"
          fill_in "category_name", with: "dog"
          click_on "Create Category"


          visit categories_path
          click_on "New Category"
          fill_in "category_name", with: "dog"
          click_on "Create Category"

          expect(page).to have_content "Please enter an original category name"
        end
      end

      context "given a category which you want to delete" do
        it "allows you to delete the offending category" do
          visit categories_path
          click_on "New Category"
          fill_in "category_name", with: "dog"
          click_on "Create Category"
          click_on "Back to manage categories"
          click_on "Delete Category"
          expect(page).to have_content "Products"
        end
      end
    end
  end
end
