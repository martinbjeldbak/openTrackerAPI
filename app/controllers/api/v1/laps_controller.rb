module Api
  module V1
    class LapsController < ApplicationController
      skip_authorization_check

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

      private

      def load_and_auth_sess
        @session = Session.find_by_id params[:session_id]
        ensure_session_auth @session
      end

      def laps_params
        params.require(:lap).permit(:lap_nr)
      end
    end
  end
end