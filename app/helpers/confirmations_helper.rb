module ConfirmationsHelper

  def confirmation_message(confirmation)
    puts confirmation.inspect
    if confirmation.action == 'accept'
      "join #{confirmation.confirmable.name}"
    else
      "reject joining #{confirmation.confirmable.name}"
    end
  end

  def confirm_confirmation_button(confirmation)
    button_to "Yes", do_confirmation_url(@confirmation)
  end

  def cancel_confirmation_button(confirmation)
    link_to "No (you will be redirected)", root_path
  end
end
