class LapsController < ApplicationController
  skip_authorization_check

  before_filter :load_and_auth_sess

  def index

  end

  def create
    lap = Lap.new(laps_params)
    lap.race_session = @race_session

    respond_to do |format|
      if lap.save
        format.json { render json: lap, status: :created }
      else
        format.json { render json: lap, status: :unprocessable_entity }
      end
    end
  end

  private

  def load_and_auth_sess
    @race_session = RaceSession.find_by_id params[:race_session_id]
    ensure_session_auth @race_session
  end

  def laps_params
    params.require(:lap).permit(:lap_nr)
  end
end
