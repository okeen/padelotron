module ConfirmationsHelper

  def confirmation_ask_message(confirmation)
    if confirmation.action == 'accept'
      confirmation.confirmation_ask_message
    else
      confirmation.rejection_ask_message
    end
  end

  def confirmation_message(confirmation)
    if confirmation.action == 'accept'
      confirmation.confirmation_message
    else
      confirmation.rejection_message
    end
  end

  def confirm_confirmation_button(confirmation)
    button_to "Yes", do_confirmation_url(confirmation)
  end

  def cancel_confirmation_button(confirmation)
    link_to "No (you will be redirected)", root_path
  end
end
