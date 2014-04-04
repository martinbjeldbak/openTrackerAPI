module Api
  module V1
    class SessionsController < ApplicationController
      skip_authorization_check

      class Session < ::Session

      end

      respond_to :json

      def create
        user = User.find_by_uid(session_params[:steam_id])

        if user.nil?
          respond_with({ errors: 'Could not find user' }, status: 404, location: 'nil')
        else
          key = ApiKey.create!

          @session = user.sessions.build(api_key_id: key.id, user_id: user.id, started_at: Time.now)

          respond_with key.access_token, status: 200, location: 'nil' if @session.save
        end
      end

      private
      def session_params
        params.require(:session).permit(:steam_id)

      end
    end
  end
end