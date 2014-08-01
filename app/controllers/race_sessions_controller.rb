class RaceSessionsController < ApplicationController
  load_resource
  skip_authorization_check

  before_filter ->(c) { c.ensure_session_auth @race_session}, only: :update


  def index
    @race_sessions = RaceSession.all

    respond_to do |format|
      if @race_sessions
        format.json { render json: @race_sessions, status: 200 }
      else
        format.json { render json: { errors: @race_sessions.errors.full_messages }, status: 404 }
      end
    end

  end

  def show
    respond_to do |format|
      if @race_session
        format.json { render json: @race_session, methods: :key, status: 200 }
      else
        format.json ( render json: { errors: @race_session.errors.full_messages}, status: 404 )
      end
    end
  end

  def create
    user = User.find_by_id race_session_params[:user_id]

    if user
      respond_to do |format|
        session = user.race_sessions.build(race_session_params)
        session.started_at = Time.now

        if session.save
          format.json { render json: session, status: :created }
        else
          format.json { render json: session }
        end
      end
    else
      format.json { render json: { errors: 'Could not find user' }, status: 404, location: 'nil' }
    end



  end

  def update
    respond_to do |format|
      if @race_session.update!(race_session_params)
        format.json { render json: @race_session }
      else
        format.json { render json: @race_session.errors, status:  :unprocessable_entity }
      end
    end

  end

  private

  def race_session_params
    params.require(:race_session).permit(:ot_version, :ac_version, :user_id, :user_agent, :user_id, :ended_at)
  end
end