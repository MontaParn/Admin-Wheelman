class RaceEntriesController < ApplicationController
  before_action :set_athlete

  def new
    @race_entry = @athlete.race_entries.new(race_date: Date.current)
  end

  def create
    @race_entry = @athlete.race_entries.new(race_entry_params)

    if @race_entry.save
      redirect_to @athlete, notice: "บันทึกการแข่งขันเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @athlete.race_entries.find(params[:id]).destroy
    redirect_to @athlete, notice: "ลบรายการแข่งขันเรียบร้อยแล้ว"
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:athlete_id])
  end

  def race_entry_params
    params.require(:race_entry).permit(:race_name, :race_date, :discipline, :result)
  end
end
