class Student < ApplicationRecord
  has_many :installments, dependent: :destroy
  after_create :create_installments

  def create_installments
    installment_amount = (total_amount / number_of_installments).round(2)
    remainder = total_amount % number_of_installments

    number_of_installments.times do |i|
      amount = (i == number_of_installments - 1) ? installment_amount + remainder : installment_amount
      installments.create(amount: amount, paid: false)
    end
  end

  def pay_installment(index, amount_paid, action)
    installment = installments[index]

    if amount_paid > installment.amount
      excess = amount_paid - installment.amount
      installment.update(amount: amount_paid, paid: true, payment_date: DateTime.now)
      adjust_excess(excess, index + 1)                   
    elsif amount_paid < installment.amount
      deficit = installment.amount - amount_paid
      installment.update(amount: amount_paid, paid: true, payment_date: DateTime.now)
      handle_deficit(deficit, index + 1, action)         
    else
      installment.update(amount: amount_paid, paid: true, payment_date: DateTime.now)
    end
  end

  private

  def adjust_excess(excess_amount, next_index)
    installments[next_index..-1].each do |installment|
      break if excess_amount <= 0

      if excess_amount >= installment.amount
        excess_amount -= installment.amount
        installment.update(amount: 0, paid: true)
      else
        installment.update(amount: installment.amount - excess_amount)
        excess_amount = 0
      end
    end
  end

  def handle_deficit(deficit, next_index, action)
    next_installment = installments[next_index]

    if action == 'add_to_next' && next_installment
      next_installment.update(amount: next_installment.amount + deficit)
    elsif action == 'create_new'
      installments.create(amount: deficit, paid: false)
    end
  end
end
