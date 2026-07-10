class AthletesController < ApplicationController
  before_action :set_athlete, only: %i[show edit update destroy]

  def index
    @athletes = Athlete.all.order(:name)
  end

  def show
    @memberships = @athlete.memberships.order(start_date: :desc)
    @race_entries = @athlete.race_entries.order(race_date: :desc)
  end

  def new
    @athlete = Athlete.new(started_on: Date.current)
  end

  def create
    @athlete = Athlete.new(athlete_params)

    if @athlete.save
      redirect_to @athlete, notice: "เพิ่มนักกีฬาเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @athlete.update(athlete_params)
      redirect_to @athlete, notice: "บันทึกข้อมูลเรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @athlete.destroy
    redirect_to athletes_path, notice: "ลบนักกีฬาเรียบร้อยแล้ว"
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:id])
  end

  def athlete_params
    params.require(:athlete).permit(:name, :phone, :line_user_id, :started_on, :notes, :active)
  end
end
