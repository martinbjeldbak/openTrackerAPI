class UsersController < ApplicationController
  load_and_authorize_resource

  skip_authorize_resource only: :search
  skip_authorization_check only: :search

  before_filter :authenticate_user!, except: :search

  def index
    respond_with @users
  end

  def show
    respond_to do |format|
      format.html do
        flash[:success] = "#{@user.name} is currently racing" if @user.is_racing?
      end
      format.json { render json: @user }
    end

  end

  def search
    @users = User.search(params[:q]).order('created_at DESC')

    respond_to do |format|
      format.json { render json: @users }
    end
  end
end