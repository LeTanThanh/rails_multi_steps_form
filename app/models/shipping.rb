class Shipping < ApplicationRecord
  validates :receiver_name, presence: true, if: :validate_receiver?
  validates :receiver_phone, presence: true, if: :validate_receiver?
  validates :shipping_address, presence: true, if: :validate_shipping?
  validates :shipping_day, presence: true, if: :validate_shipping?

  attr_accessor :current_step

  def move_next_step
    @current_step = steps[current_step_index + 1]
  end

  def move_pre_step
    @current_step = steps[current_step_index - 1]
  end

  private

  def current_step_index
    steps.index current_step
  end

  def steps
    %w|receiver shipping confirmation|
  end

  def validate_receiver?
    current_step.blank? || current_step == "receiver"
  end

  def validate_shipping?
    current_step.blank? || current_step == "shipping"
  end
end
