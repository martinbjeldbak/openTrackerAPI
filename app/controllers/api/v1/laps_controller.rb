module Api
  module V1
    class LapsController < ApplicationController
      skip_authorization_check

      before_filter :load_and_auth_sess

      def index

      end

      def create
        lap = Lap.new(laps_params)
        lap.session = @session

        if lap.save
          render json: lap, status: :created
        else
          render json: lap
        end
      end

      private

      def load_and_auth_sess
        @session = RaceSession.find_by_id params[:session_id]
        ensure_session_auth @session
      end

      def laps_params
        params.require(:lap).permit(:lap_nr)
      end
    end
  end
end