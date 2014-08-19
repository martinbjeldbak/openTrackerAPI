class LapsController < ApplicationController
  skip_authorization_check

  load_resource :race_session
  load_resource :user
  load_resource through: :race_session

  before_filter ->(c) { c.ensure_session_auth @race_session}

  def index
    respond_to do |format|
      format.html
      format.json { render json: @laps, status: 200 }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @lap, status: 200}
    end
  end

  def create
    lap = Lap.new(lap_params)
    lap.race_session = @race_session

    respond_to do |format|
      format.json do
        if lap.save
          render json: lap, status: :created
        else
          render json: lap, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def lap_params
    params.require(:lap).permit(:lap_nr)
  end
end
