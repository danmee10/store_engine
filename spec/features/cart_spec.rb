require "spec_helper"

describe "cart page" do
  context "ready to purchase" do
    it "has a checkout button" do
      visit cart_path
      expect(page).to have_link "Proceed to checkout"
    end

    it "can increase or decrease the quantity" do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure")
      product = Product.create(title: "tv", description: "something", price: 9.99)

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'

      visit products_path
      click_on "View details"
      click_on "Add to cart"

      visit cart_path
      click_on "+"
      expect(page).to have_content 2

      visit cart_path
      click_on "-"
      expect(page).to have_content 1
    end

    it "removes the product from the cart if the quantity is zero" do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure")
      product = Product.create(title: "tv", description: "something", price: 9.99)

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'

      visit products_path
      click_on "View details"
      click_on "Add to cart"

      visit cart_path
      click_on "-"
      expect(page).to have_content 0
    end

    it "has a clickable remove button" do
      product = Product.create(title: "tv", description: "something", price: 9.99)

      visit products_path
      click_on "View details"
      click_on "Add to cart"
      visit cart_path
      click_on "Remove"
    end
  end

  context "after clicking 'checkout'" do
    it "should be redirected to the confirmation page" do
      visit cart_path
      click_link "Proceed to checkout"
      expect( current_path ).to eq '/login'
      expect( page ).to have_content 'please log in to complete your order'
    end
  end
end

describe "shopping cart" do
  context "you add items to your cart, then log in to an account with stuff in its cart" do
    it "merges the carts" do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure")
      product = Product.create(title: "tv", description: "something", price: 9.99)

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'

      visit products_path
      click_on "View details"
      click_on "Add to cart"
      visit cart_path
      expect(page).to have_content 1

      click_on "(logout)"

      visit products_path
      click_on "View details"
      click_on "Add to cart"
      visit cart_path
      expect(page).to have_content 1

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'

      visit cart_path
      expect(page).to have_content 2
    end
  end
end
















