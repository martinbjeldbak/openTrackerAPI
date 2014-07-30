module Api
  module V1
    class UsersController < ApplicationController
      load_and_authorize_resource

      skip_authorize_resource only: :search
      skip_authorization_check only: :search

      respond_to :json

      before_filter :authenticate_user!, except: :search

      def index
        respond_with @users
      end

      def show
        render json: @user
      end

      def search
        @users = User.search(params[:q]).order('created_at DESC')

        logger.debug(@users.inspect)

        render json: @users
      end
    end
  end
end