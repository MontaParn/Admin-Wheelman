class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  def show
    @available_athletes = Athlete.where.not(id: @event.athletes.select(:id)).order(:name)
  end

  def new
    @event = Event.new(category: :race, start_date: Date.current, end_date: Date.current)
  end

  def create
    @event = Event.new(event_params)

    if @event.save
      redirect_to @event, notice: "สร้างกิจกรรมเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @event.photo.purge if event_params[:remove_photo] == "1"

    if @event.update(event_params.except(:remove_photo))
      redirect_to @event, notice: "บันทึกกิจกรรมเรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @event.destroy
    redirect_to calendar_path, notice: "ลบกิจกรรมเรียบร้อยแล้ว"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :photo, :remove_photo, :category, :run, :swim, :bike,
      :description, :location, :google_map_link, :start_date, :end_date
    )
  end
end
