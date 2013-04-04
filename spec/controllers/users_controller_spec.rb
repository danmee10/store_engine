require 'spec_helper'

describe UsersController do

  let!(:user1) {User.create(username: "dan",
                            email: "danmee@gmail.com",
                            first_name: "dan",
                            last_name: "mee",
                            password: "qweqweqwe")}

  describe "#index" do
    it "renders the user index page" do
      get :index
      response.should be_success
      expect(response).to render_template :index
    end
  end

  describe "#show" do
    it "renders the user form" do
      get :show, id: 1
      response.should be_success
      expect(response).to render_template :show
    end
  end

  describe "#new" do
    it "renders the user detail page" do
      get :new
      response.should be_success
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    it "renders the edit user page" do
      get :edit, id: 1
      response.should be_success
      expect(response).to render_template :edit
    end
  end

  describe "#create" do

      let(:new_user) do {user: { username: "dmee",
                    first_name: "andy",
                    last_name: "moe",
                    email: "doe@may.com",
                    password: "asdasdasd"} }
      end

    it "creates/saves a new user" do
      expect( post :create, new_user).to change(User, :count).by(1)
      # response.should be_success
    end
  end

  describe "#update" do
    it "renders the user detail page" do
      pending
      get :new
      response.should be_success
      expect(response).to render_template :new
    end
  end
end
