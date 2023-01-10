require 'rails_helper'
require 'pry'

RSpec.describe UsersController, type: :controller do
	let(:admin) {create :user, :admin, confirmed_at: Date.yesterday}
	let(:user) {create :user, confirmed_at: Date.yesterday}
	describe "get index" do 
		it "when user is not admin" do 
			sign_in user
			expect(user).to be_persisted
			get :index
			expect(response).to redirect_to(root_path)
		end 
        it "when user is admin" do 
			sign_in admin
			get :index
			expect(response).to render_template(:index)
		end
    end
    describe "#show" do
        it "get show" do 
        	sign_in admin
        	get :show, params: {id: user.id}
        	expect(response).to render_template(:show)
        end 
    end
    describe "#edit" do
        it "get edit" do 
        	sign_in admin
        	get :edit, params: {id: user.id}
        	expect(response).to render_template(:edit)
        end 
    end
    describe "#update" do
        it "update user" do 
        	sign_in admin
        	patch :update, params: {id: 3, user: { phone_number: "2225555555" }}
        	expect(response).to redirect_to(user_path)
        end 
    end
end
