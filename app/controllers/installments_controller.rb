class InstallmentsController < ApplicationController
  def pay
    @student = Student.find(params[:id])
    installment_index = params[:installment_index].to_i
    amount_paid = params[:amount_paid].to_f
    action = params[:action_choice]
    installments = @student.installments

    if installment_index == @student.installments.size - 1 && amount_paid < installments[installment_index].amount && action == "add_to_next"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("error-message", partial:"students/error_message", locals: { error_message: "payment amount can not be less than remaining" })
        end
      end
    else
      @student.pay_installment(installment_index, amount_paid, action)
      redirect_to student_path(@student), notice: "Installment paid successfully."
    end
  end

end
