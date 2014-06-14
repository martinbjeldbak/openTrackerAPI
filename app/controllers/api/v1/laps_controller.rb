module Api
  module V1
    class LapsController < ApplicationController
      load_resource :session
      load_resource through: :session
      #load_and_authorize_resource :session
      #load_and_authorize_resource through: :session

      # lap_nr, session

      before_filter ->(c) { c.ensure_session_auth @session}

      def index

      end

      def create

      end

      def update

      end

      private

      def laps_params
        params.require(:lap).permit(:lap_nr, :session_id)
      end
    end
  end
end