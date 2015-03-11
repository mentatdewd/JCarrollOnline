require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

  # let(:user) { FactoryGirl.create(:user) }
  # let(:other_user) { FactoryGirl.create(:user) }
  # before { sign_in user, no_capybara: true }

  # This should return the minimal set of attributes required to create a valid
  # ForumThread. As you add validations to ForumThread, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ForumThreadsController. Be sure to keep this updated too.
  def valid_session
    { }
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
    #user = FactoryGirl.create(:user)
      get :show, { :id => user }, valid_session
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    it "returns http success" do
      get :create
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
    #user = FactoryGirl.create(:user)
      get :edit, { :id => user }, valid_session
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #index" do
    it "returns http success" do
      user = FactoryGirl.create(:user)
      get :index, {}, valid_session
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update, { :id => user }, valid_session
      expect(response).to redirect_to(:user)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to redirect_to(root_path)
    end
  end

end

private

def sign_in(user, options={})
  if options[:no_capybara]
    #Sign in when not using Capybara
    #remember_token = User.new_remember_token
    #cookies[:remember_token] = remember_token
    #user.update_attribute(:remember_token, User.encrypt(remember_token))
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user
    else
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
  end
end  