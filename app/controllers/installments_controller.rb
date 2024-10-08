class InstallmentsController < ApplicationController
  def pay
    @student = Student.find(params[:id])
    installment_index = params[:installment_index].to_i
    amount_paid = params[:amount_paid].to_f
    action = params[:action_choice]

    @student.pay_installment(installment_index, amount_paid, action)

    redirect_to student_path(@student), notice: 'Payment processed successfully.'
  end
end
