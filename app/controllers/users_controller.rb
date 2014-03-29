class UsersController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  def index
  end

  def show
  end
end
