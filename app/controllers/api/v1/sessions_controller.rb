module Api
  module V1
    class SessionsController < ApplicationController
      load_resource
      skip_authorization_check

      class Session < ::Session
      end

      respond_to :json

      def index
        @sessions = Session.all

        if @sessions
          respond_with @sessions, status: 200
        else
          respond_with({ errors: @sessions.errors.full_messages }, status: 404)
        end
      end

      def show
        if @session
          respond_with @session, status: 200
        else
          respond_with({ errors: @session.errors.full_messages}, status: 404)
        end
      end

      def create
        user = User.find_by_id session_params[:user_id]

        if user
          @session = user.sessions.build(user: user, started_at: Time.now, version: session_params[:version])

          respond_with @session, status: 200, location: 'nil' if @session.save
        else
          respond_with({ errors: 'Could not find user' }, status: 404, location: 'nil')
        end
      end

      private

      def session_params
        params.require(:session).permit(:version, :user_id)
      end
    end
  end
end