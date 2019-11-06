require 'spec_helper'

describe ProfilesController do
  log_in_as :student

  describe "GET edit" do
    it "assigns my user to @user" do
      get :edit
      expect(assigns(:user)).to eq current_user
    end

    it "denies access if unauthenticated" do
      controller.stub current_user: nil
      get :edit
      expect(response).to deny_access
    end
  end

  describe "PUT update" do
    before do
      controller.stub :sign_in
      current_user.stub :update_attributes
    end

    it "assigns my user to @user" do
      put :update
      expect(assigns(:user)).to eq current_user
    end

    it "updates my user" do
      expect(current_user).to receive(:update_attributes).with('attributes')
      put :update, user: 'attributes'
    end

    it "redirects to the dashboard on success" do
      current_user.stub update_attributes: true
      put :update
      expect(response).to redirect_to(dashboard_path)
    end

    it "refreshes the credentials in session on success" do
      expect(controller).to receive(:sign_in).with(current_user, bypass: true)
      current_user.stub update_attributes: true
      put :update
    end

    it "redisplays the form on failure" do
      current_user.stub update_attributes: false
      put :update
      expect(response).to render_template(:edit)
    end
  end
end
