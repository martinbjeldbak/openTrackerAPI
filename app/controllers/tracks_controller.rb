class TracksController < ApplicationController
  load_resource

  def show
    respond_to do |format|
      format.json { render json: @track }
    end
  end

  def index
    respond_to do |format|
      format.json { render json: @tracks }
    end
  end
end
