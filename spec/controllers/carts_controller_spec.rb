require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:admin) {create :user, admin: true, confirmed_at: Date.yesterday}
  let(:user) {create :user, confirmed_at: Date.yesterday}
  let(:user2) {create :user, confirmed_at: Date.yesterday}
  let!(:cart) {create :cart, user: user}
  let!(:cart2) {create :cart, user: user2}

  describe "GET index" do
    it "when user is admin" do
      sign_in admin
      get :index
      expect(response).to render_template(:index)
    end
    it "when user is not admin" do
      sign_in user
      get :index
      expect(response).to redirect_to(root_path)
    end
  end
  
  describe "GET show" do
    it "dont show users cart for admin" do
      sign_in admin
      admin_cart = Cart.find_by(user_id: admin.id, purchased_at: nil)
      session[:cart_id] = admin_cart.id if admin_cart.present?
      get :show, params: {id: cart.id }
      expect(response).to redirect_to(root_path)
    end
    it "show cart for user" do
      sign_in user
      user_cart = Cart.find_by(user_id: user.id, purchased_at: nil)
      session[:cart_id] = user_cart.id if user_cart.present?
      get :show, params: {id: cart.id }
      expect(response).to render_template(:show)
    end
    it "dont show one users cart to other user" do
      sign_in user2
      user2_cart = Cart.find_by(user_id: user2.id, purchased_at: nil)
      session[:cart_id] = user2_cart.id if user2_cart.present?
      get :show, params: {id: cart.id }
      expect(response).to redirect_to(root_path) 
    end
  end


  describe "GET cart" do
    it "show users cart for admin" do
      sign_in admin
      get :cart_list, params: {id: cart.id}
      expect(response).to render_template(:cart_list)
    end
  end

  describe "GET #destroy" do
    it "destroy cart of other user" do
      sign_in user2
      user2_cart = Cart.find_by(user_id: user2.id, purchased_at: nil)
      session[:cart_id] = user2_cart.id if user2_cart.present?
      get :destroy, params: {id: cart.id}
      expect(response).to redirect_to(root_path)
    end
    it "destroy own cart" do
      sign_in user
      user_cart = Cart.find_by(user_id: user.id, purchased_at: nil)
      session[:cart_id] = user_cart.id if user_cart.present?
      get :destroy, params: {id: cart.id}
      expect(response).to redirect_to(gallery_index_path)
    end
  end

end
