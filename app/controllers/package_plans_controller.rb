class PackagePlansController < ApplicationController
  before_action :set_package_plan, only: %i[edit update destroy]

  def index
    @package_plans = PackagePlan.order(:name)
  end

  def new
    @package_plan = PackagePlan.new(billing_cycle: :monthly, active: true)
  end

  def create
    @package_plan = PackagePlan.new(package_plan_params)

    if @package_plan.save
      redirect_to package_plans_path, notice: "เพิ่มแพคเกจเรียบร้อยแล้ว"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @package_plan.update(package_plan_params)
      redirect_to package_plans_path, notice: "บันทึกแพคเกจเรียบร้อยแล้ว"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @package_plan.destroy
      redirect_to package_plans_path, notice: "ลบแพคเกจเรียบร้อยแล้ว"
    else
      redirect_to package_plans_path, alert: @package_plan.errors.full_messages.to_sentence
    end
  end

  private

  def set_package_plan
    @package_plan = PackagePlan.find(params[:id])
  end

  def package_plan_params
    params.require(:package_plan).permit(:name, :run, :swim, :bike, :billing_cycle, :duration_days, :price, :active)
  end
end
