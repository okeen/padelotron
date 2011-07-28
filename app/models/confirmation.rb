class Confirmation < ActiveRecord::Base
  belongs_to :confirmable, :polymorphic => true


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
