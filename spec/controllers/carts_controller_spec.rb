require 'rails_helper'

RSpec.describe CartsController, type: :controller do
  let(:admin) {create :user, admin: true, confirmed_at: Date.yesterday}
  let(:user) {create :user, confirmed_at: Date.yesterday}
  let(:cart) {create :cart, user: user}

  describe "GET index" do
    it "index" do
      sign_in admin
      get :index
      expect(response).to render_template(:index)
    end
  end
  
  describe "GET show" do
    it "show users cart" do
      sign_in user
      session[:cart_id] = cart.id
      get :show, params: {id: cart.id }
      expect(response).to render_template(:show)
    end
  end


  describe "GET cart" do
    it "list" do
      sign_in admin
      get :cart_list, params: {id: cart.id}
      expect(response).to render_template(:cart_list)
    end
  end

  describe "GET #destroy" do
    it "destroy" do
      sign_in admin
      get :destroy, params: {id: cart.id}
      expect(response).to redirect_to(gallery_index_path)
    end
  end

end
