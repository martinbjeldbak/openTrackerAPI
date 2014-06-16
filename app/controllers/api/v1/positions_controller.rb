module Api
  module V1
    class PositionsController < ApplicationController
      skip_authorization_check
      before_filter :load_parents
      before_filter :load_and_auth_sess

      respond_to :json

      def create
        @position = Position.new position_params
        @position.lap = @lap

        if @position.save
          respond_with @position, status: 200, location: 'nil'
        else
          respond_with @position, status: :unprocessable_entity
        end
      end

      private

      def position_params
        params.require(:position).permit(:x, :y, :z)
      end

      def load_parents
        @lap = Lap.find_by_id(params[:lap_id])
        @session = @lap.session
      end

      def load_and_auth_sess
        ensure_session_auth @session
      end
    end
  end
end