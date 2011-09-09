module Confirmable
  extend ActiveSupport::Concern

  included do
    has_many :confirmations, :as => :confirmable

    after_create :set_initial_status,
      :create_confirmations_if_needed,
      :deliver_ask_email,
      :create_ask_notifications
      
    default_scope where(:status => "confirmed")
    
    scope :unconfirmed, where(:status => 'new')

  end

  module ClassMethods
  
  end

  module InstanceMethods
    def confirm!
      update_attributes :status => 'confirmed'
      deliver_confirmation_email
      create_confirmation_notifications
      on_confirm
    end

    def reject!
      update_attribute :status , 'rejected'
      deliver_cancellation_email
      create_rejection_notifications
      on_reject
    end

    def needs_confirmation?
      #default
      true
    end

    private

    def create_confirmation_notifications
      factory_method= self.class == Team ? "TEAM_CONFIRMED" :
                      self.class == Game ? "GAME_CONFIRMED" :
                      self.class == Result ? "RESULT_CONFIRMED" : nil
      players.each do |player|
        player.notifications.create NotificationType.send(factory_method, self)
      end
    end
    
    def create_rejection_notifications
      factory_method= self.class == Team ? "TEAM_CONFIRMED" :
                      self.class == Game ? "GAME_CONFIRMED" :
                      self.class == Result ? "RESULT_CONFIRMED" : nil
      players.each do |player|
        player.notifications.create NotificationType.send(factory_method, self)
      end
    end

    def create_confirmations_if_needed
      return true unless self.needs_confirmation?
      ["accept", "reject"].each do |action_name|
        self.confirmations << Confirmation.new(:action => action_name, :code => rand(1000000000000).to_s)
      end
    end

    def create_ask_notifications
      #return true unless self.needs_confirmation?
      logger.debug "kjlkjl"
      factory_method= self.class == Team ? "NEW_TEAM" :
                      self.class == Game ? "NEW_GAME" :
                      self.class == Result ? "NEW_RESULT" : nil
      confirmating_player_groups.each do |notificating_group|
        notificating_group.each do |player|
          player.notifications.create NotificationType.send(factory_method, self)
        end
      end
    end

    def mailer
      "#{self.class}Mailer".constantize
    end

    def deliver_ask_email
      mailer.ask_mail(self).deliver
    end

    def deliver_confirmation_email
        mailer.confirmation_mail(self).deliver
    end

    def deliver_cancellation_email
        mailer.cancellation_mail(self).deliver
    end

    def set_initial_status
      update_attribute :status , 'new'
      save
    end

    def on_confirm

    end
      
    def on_reject

    end
  end

end