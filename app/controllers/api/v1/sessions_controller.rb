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
        user = User.find_by_uid(session_params[:steam_id])

        respond_with({ errors: 'Could not find user' }, status: 404, location: 'nil') if user.nil?

        @session = user.sessions.build(user_id: user.id, started_at: Time.now, version: session_params[:version])

        respond_with @session, status: 200, location: 'nil' if @session.save
      end

      private

      def session_params
        params.require(:session).permit(:steam_id, :version, :user_agent)
      end
    end
  end
end