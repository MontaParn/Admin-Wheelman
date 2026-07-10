class EventAttendancesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    event.event_attendances.find_or_create_by!(athlete_id: params[:athlete_id])

    redirect_to event, notice: "เพิ่มนักกีฬาเข้ากิจกรรมเรียบร้อยแล้ว"
  end

  def destroy
    event = Event.find(params[:event_id])
    event.event_attendances.find(params[:id]).destroy

    redirect_to event, notice: "นำนักกีฬาออกจากกิจกรรมเรียบร้อยแล้ว"
  end
end
