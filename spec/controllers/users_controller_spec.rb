# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let!(:daily_record) { create(:daily_record, male_count: 1, female_count: 0) }

  describe "testing index action" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "test delete action" do
    it "destroys the requested user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "updates the daily record for male count" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change { daily_record.reload.male_count }.by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, params: { id: user.id }
      expect(response).to redirect_to(users_path)
    end
  end
end
