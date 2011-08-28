module Customers::PlaygroundRequestsHelper

  def confirm_reservation_button(reservation)
    button_to "Yes", do_confirmation_url(reservation)
  end

  def cancel_reservation_button(reservation)
    link_to "No (you will be redirected)", customer_path(current_customer)
  end
end
