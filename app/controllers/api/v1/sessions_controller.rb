module Api
  module V1
    class SessionsController < ApplicationController
      load_resource
      skip_authorization_check

      before_filter ->(c) { c.ensure_session_auth @session}, only: :update

      respond_to :json


      class Session < ::Session
      end

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
          respond_with @session, methods: :key, status: 200
        else
          respond_with({ errors: @session.errors.full_messages}, status: 404)
        end
      end

      def create
        user = User.find_by_id session_params[:user_id]

        if user
          session = user.sessions.build(session_params)
          session.started_at = Time.now

          if session.save
            respond_with session, status: :created
          else
            respond_with session
          end

        else
          respond_with({ errors: 'Could not find user' }, status: 404, location: 'nil')
        end
      end

      def update
        if @session.update!(session_params)
          respond_with @session
        else
          respond_with @session.errors, status:  :unprocessable_entity
        end
      end

      private

      def session_params
        params.require(:session).permit(:ot_version, :ac_version, :user_id, :user_agent, :user_id, :ended_at)
      end

      # http://railscasts.com/episodes/352-securing-an-api
      #def restrict_access
      #  authenticate_or_request_with_http_token do |token, options|
      #    Key.exists?(key: token)
      #  end
      #end
    end
  end
end