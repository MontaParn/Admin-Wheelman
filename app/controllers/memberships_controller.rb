class MembershipsController < ApplicationController
  before_action :set_athlete
  before_action :set_membership, only: %i[edit update]

  def new
    @membership = @athlete.memberships.new(start_date: Date.current)
    @package_plans = PackagePlan.active
  end

  def create
    package_plan = PackagePlan.find(membership_params[:package_plan_id])
    start_date = membership_params[:start_date].presence || Date.current

    @membership = @athlete.memberships.new(
      package_plan: package_plan,
      start_date: start_date,
      end_date: start_date.to_date + package_plan.duration_days.days,
      price_paid: package_plan.price
    )

    if @membership.save
      @membership.payments.create!(amount: package_plan.price, due_on: start_date)
      redirect_to @athlete, notice: "สมัครแพคเกจเรียบร้อยแล้ว"
    else
      @package_plans = PackagePlan.active
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @package_plans = PackagePlan.active
  end

  def update
    if @membership.update(membership_update_params)
      redirect_to @athlete, notice: "แก้ไขข้อมูลสมาชิกเรียบร้อยแล้ว"
    else
      @package_plans = PackagePlan.active
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_athlete
    @athlete = Athlete.find(params[:athlete_id])
  end

  def set_membership
    @membership = @athlete.memberships.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:package_plan_id, :start_date)
  end

  def membership_update_params
    params.require(:membership).permit(:start_date, :end_date, :cancelled_at)
  end
end
