# frozen_string_literal: true
module CheckoutHelper
  %i(year month).each do |field|
    define_method "#{field}_select_options" do
      { collection: (send "#{field}_range"), prompt: :translate }
    end
  end

  def month_range
    (1..12).map { |month| month.to_s.rjust 2, '0' }
  end

  def year_range
    year_range_start..year_range_finish
  end

  def year_range_start
    Time.now.year
  end

  def year_range_finish
    (Time.now + 20.years).year
  end

  def step_button_options(step)
    clazz = 'btn navbar-btn '
    clazz += current_step?(step) ? 'btn-primary' : 'btn-default'
    { onclick: "window.location.href='#{wizard_path step}'", class: clazz }
  end

  def shipping_checkbox_options
    { type: :checkbox, name: 'as-billing-address' }
  end

  def delivery_method_options
    { label: false, collection: DeliveryMethod.active.cheap.decorate,
      as: :radio_buttons, label_method: :formatted_name }
  end
end
