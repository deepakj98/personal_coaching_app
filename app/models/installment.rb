class Installment < ApplicationRecord
  belongs_to :student

  scope :completely_paid, -> { where(paid: true)}
end
