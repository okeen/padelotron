module Customers::PlaygroundRequestsHelper

  def confirm_reservation_action_button(reservation, confirm)
    button_to "Yes", customers_do_playground_request_path(confirm ?
        reservation.accept_code : reservation.reject_code)
  end

  def cancel_reservation_action_button(reservation)
    link_to "No (you will be redirected)", customer_path(current_customer)
  end
end
