require 'spec_helper'

describe "products" do
  context "given a product" do

    before(:each) do
      @product = Product.create(title: "trail bike", description: "it's fast",
                              price: 69.99)
    end

    it "has a show page" do
      visit products_path(@product)
      expect(page).to have_content "trail bike"
    end

    context "an admin is signed in" do
      it "can edit a product" do
        @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                            last_name: "garciad", password: "thisissecure", admin: true)

        visit login_path
        fill_in 'login_id', with: 'dantheman@gmail.com'
        fill_in 'password', with: 'thisissecure'
        click_button 'Login'
        click_on "Manage Products"
        click_on "Edit"
        fill_in "Title", with: "dinosaur"
        click_on "Update Product"
        expect(page).to have_content "dinosaur"
      end


      it "can create a new product" do
        @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                            last_name: "garciad", password: "thisissecure", admin: true)
        visit login_path
        fill_in 'login_id', with: 'dantheman@gmail.com'
        fill_in 'password', with: 'thisissecure'
        click_button 'Login'
        click_on "New Products"
        fill_in 'Title', with: 'dinosaur'
        fill_in 'Description', with: 'big and greeen'
        fill_in 'Price', with: 34
        click_on "Create Product"
        expect(page).to have_content "Product successfully created!"
      end

      it "cannot create a product without valid criteria" do
        @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                            last_name: "garciad", password: "thisissecure", admin: true)
        visit login_path
        fill_in 'login_id', with: 'dantheman@gmail.com'
        fill_in 'password', with: 'thisissecure'
        click_button 'Login'
        click_on "New Products"
        fill_in 'Title', with: ''
        fill_in 'Description', with: 'big and greeen'
        fill_in 'Price', with: 34
        click_on "Create Product"
        expect(page).to have_content "New product 1 error prohibited"
      end
    end
  end
end
