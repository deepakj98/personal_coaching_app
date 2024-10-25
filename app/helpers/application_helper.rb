module ApplicationHelper
    def max_amount_to_be_paid(student)
        student.total_amount - student.installments.completely_paid.sum(:amount)
    end
end
