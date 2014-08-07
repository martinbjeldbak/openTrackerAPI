class PositionsController < ApplicationController
  skip_authorization_check
  before_filter :load_parents
  before_filter :load_and_auth_sess

  def create
    position = Position.new position_params
    position.lap = @lap

    respond_to do |format|
      if position.save
        WebsocketRails["race_session_#{@race_session.id}_positions"].trigger(:create, position)
        format.json { render json: position, status: :created }
      else
        logger.debug("Could not save position due to the following errors: #{position.errors.full_messages}")
        format.json { render json: position, status: :unprocessable_entity }
      end
    end
  end

  private

  def position_params
    params.require(:position).permit(:x, :y, :z, :speed, :rpm, :gear,
                                     :on_gas, :on_brake, :on_clutch, :steer_rot)
  end

  def load_parents
    @lap = Lap.find_by_id(params[:lap_id])
    @race_session = RaceSession.find_by_id(params[:race_session_id])
  end

  def load_and_auth_sess
    ensure_session_auth @race_session
  end
end