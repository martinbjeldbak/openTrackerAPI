class UsersController < ApplicationController
  load_and_authorize_resource

  skip_authorize_resource only: :search
  skip_authorization_check only: :search

  before_filter :authenticate_user!, except: :search

  def index
  end

  def show
  end

  def search
    @users = User.search(params[:q]).order('created_at DESC')



    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end
end
