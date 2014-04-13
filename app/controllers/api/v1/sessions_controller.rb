module Api
  module V1
    class SessionsController < ApplicationController
      #protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

      skip_authorization_check


      class Session < ::Session
      end

      respond_to :json

      def create
        user = User.find_by_uid(session_params[:steam_id])

        if user.nil?
          respond_with({ errors: 'Could not find user' }, status: 404, location: 'nil')
        else

          @session = user.sessions.build(user_id: user.id, started_at: Time.now, version: session_params[:version])

          respond_with @session.key, status: 200, location: 'nil' if @session.save
        end
      end

      private

      def session_params
        params.require(:session).permit(:steam_id, :version, :user_agent)
      end
    end
  end
end