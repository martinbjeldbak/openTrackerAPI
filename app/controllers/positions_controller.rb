class PositionsController < ApplicationController
  skip_authorization_check

  load_resource :user
  load_resource :race_session
  load_resource :lap
  load_resource through: :lap

  before_filter ->(c) { c.ensure_session_auth @race_session}

  def create
    position = Position.new position_params
    position.lap = @lap

    (position_params[:on_clutch] == 1.0) ? position.on_clutch = true : position.on_clutch = false

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
end