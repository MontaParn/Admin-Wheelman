class PaymentsController < ApplicationController
  def update
    payment = Payment.find(params[:id])
    payment.mark_paid!

    redirect_to athlete_path(payment.membership.athlete), notice: "บันทึกการชำระเงินเรียบร้อยแล้ว"
  end
end
