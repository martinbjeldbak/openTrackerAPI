module Api
  module V1
    class LapsController < ApplicationController
      skip_authorization_check
      #load_resource :session
      #load_resource through: :session
      #load_and_authorize_resource :session
      #load_and_authorize_resource through: :session

      # lap_nr, session

      #before_filter ->(c) { c.ensure_session_auth @session}

      before_filter :load_and_auth_sess

      respond_to :json

      def index

      end

      def create
        @lap = Lap.new(laps_params)
        @lap.session = @session

        if @lap.save
          respond_with @lap, status: 200, location: 'nil'
        else
          respond_with @lap, status: :unprocessable_entity
        end
      end

      def update

      end

      private

      def load_and_auth_sess
        @session = Session.where(id: params[:session_id]).first

        ensure_session_auth(@session)
      end

      def laps_params
        params.require(:lap).permit(:lap_nr)
      end
    end
  end
end