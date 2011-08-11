class Confirmation < ActiveRecord::Base
  belongs_to :confirmable, :polymorphic => true

  delegate :confirmation_message, :to => :confirmable
  delegate :rejection_message, :to => :confirmable
  delegate :confirmation_ask_message, :to => :confirmable
  delegate :rejection_ask_message, :to => :confirmable

  scope :to_accept, lambda {
      where(:action=> 'accept')
  }

  scope :to_reject, lambda {
      where(:action=> 'reject')
  }
  
  def to_param
    code
  end

end

