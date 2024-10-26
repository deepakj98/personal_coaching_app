class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)

    if params[:student][:total_amount].to_i < 10000 || params[:student][:total_amount].to_i > 50000
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace('student-error-message' , partial: 'students/student_error_message', locals: {error_message: "Total amount can not be less than 10000 and greater than 50000"})
        end
      end
    elsif @student.save
      redirect_to @student
    else
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.require(:student).permit(:name, :total_amount, :number_of_installments)
  end
end
