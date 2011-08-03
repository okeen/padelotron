class Confirmation < ActiveRecord::Base
  belongs_to :confirmable, :polymorphic => true

  delegate :confirmation_message, :to => :confirmable
  delegate :rejection_message, :to => :confirmable
  delegate :confirmation_ask_message, :to => :confirmable
  delegate :rejection_ask_message, :to => :confirmable

  class<<self
    def to_accept
      where(:action=> 'accept').first
    end

    def to_reject
      where(:action=> 'reject').first
    end
  end

  def to_param
    code
  end

end

