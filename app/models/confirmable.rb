module Confirmable
  extend ActiveSupport::Concern

  included do
    has_many :confirmations, :as => :confirmable

    after_create :set_initial_status,
      :create_confirmations_if_needed,
      :deliver_ask_email
      
    default_scope where(:status => "confirmed")
    
    scope :unconfirmed, where(:status => 'new')
    
  end

  module ClassMethods
  
  end

  module InstanceMethods
    def confirm!
      update_attributes :status => 'confirmed'
      deliver_confirmation_email
      #callback to insert custom behaviour
      on_confirm
    end

    def reject!
      update_attribute :status , 'rejected'
      deliver_cancellation_email
      #callback to insert custom behaviour
      on_reject
    end

    def needs_confirmation?
      #default
      true
    end

    private

    def create_confirmations_if_needed
      return true unless self.needs_confirmation?
      ["accept", "reject"].each do |action_name|
        self.confirmations << Confirmation.new(:action => action_name, :code => rand(1000000000000).to_s)
      end
    end

    def mailer
      "#{self.class}Mailer".constantize
    end

    def deliver_ask_email
      mailer.ask_mail(self).deliver
    end

    def deliver_confirmation_email
      confirmating_player_groups.each do |emailing_group|
        mailer.confirmation_mail(self, emailing_group).deliver
      end
    end

    def deliver_cancellation_email
      confirmating_player_groups.each do |emailing_group|
        mailer.cancellation_mail(self, emailing_group).deliver
      end
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