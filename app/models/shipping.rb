class Shipping < ApplicationRecord
  # validates :receiver_name, presence: true
  # validates :receiver_phone, presence: true
  # validates :shipping_address, presence: true
  # validates :shipping_day, presence: true

  attr_accessor :current_step

  def current_step
    @current_step ||= steps.first
  end

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
end
