class Customer::PlaygroundRequest < ActiveRecord::Base
  belongs_to :game
  belongs_to :playground

  before_create :create_codes
  after_create :deliver_ask_email_to_customer

  after_update :deliver_info_email_players_if_reservation_status_changed

  private

  def deliver_info_email_players_if_reservation_status_changed
    if (self.status == 'confirmed')
      PlaygroundRequestMailer.confirmation_mail(self.game).deliver
    else if (self.status == 'cancelled')
        PlaygroundRequestMailer.cancellation_mail(self.game).deliver
      end
    end
  end
  
  def create_codes
    self.accept_code = rand(1000000000000).to_s
    self.reject_code = rand(1000000000000).to_s
  end

  def deliver_ask_email_to_customer
    PlaygroundRequestMailer.ask_mail(playground.customer, game).deliver
  end
end
