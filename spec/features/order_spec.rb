require 'spec_helper'

describe 'Order Page' do

  context 'as a logged-in user' do
    before(:each) do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure")

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'

      visit cart_path
      click_on "Proceed to checkout"
      @order = Order.find(1)
    end

    it "should display the order page" do
      # @order = Order.create(status: "pending")
      expect(current_path).to eq order_path(@order)
      expect(page).to have_content "Review your order"
    end

    it "displays line items for that order" do

      product = Product.create(title: "tv", description: "something", price: 9.99)
      @order.line_items.create(product_id: product.id, quantity: 3,
                               unit_price: product.price,
                               sub_total: (3 * product.price)
                               )
      expect(page).to have_content "Items"
    end
  end

  context 'as an admin' do
    before(:each) do
      @user = User.create(email: "dantheman@gmail.com", first_name: "dannyg",
                          last_name: "garciad", password: "thisissecure", admin: true)
      @user2 = User.create(email: "shit@gmail.com", first_name: "ass",
                    last_name: "fuck", password: "thisissecure")

      visit login_path
      fill_in 'login_id', with: 'dantheman@gmail.com'
      fill_in 'password', with: 'thisissecure'
      click_button 'Login'
      @product = Product.create(title: "tv", description: "something", price: 9.99)
      @order = Order.create(status: "pending")
      @user2.orders << @order
      @order.line_items.create(product_id: @product.id, quantity: 3,
                               unit_price: @product.price,
                               sub_total: (3 * @product.price)
                               )
    end

    it "allows you to view an orders index" do
      visit orders_path
      expect(page).to have_content "Listing orders"
    end

    it "has a details page for each order" do
      visit orders_path
      click_on "Details"
      expect(page).to have_content "Customer order"

    end

    context "allows you to edit pending and paid orders" do
      it "lets you increase the quantity of an order" do
        visit orders_path
        click_on "Edit"
        click_on "+"
        expect(@order.line_items[0][:quantity]).to eq 4
      end

      it "lets you decrease the quantity of an order" do
        visit orders_path
        click_on "Edit"
        click_on "-"
        expect(@order.line_items[0][:quantity]).to eq 2
      end

      it "lets you delete an order" do
        visit orders_path
        click_on "Edit"
        click_on "Remove"
        expect(page).to have_content "Editing order"
      end
    end
  end
end
