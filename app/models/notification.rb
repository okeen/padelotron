class Notification < ActiveRecord::Base
  belongs_to :notification_type
  belongs_to :player

  serialize :params

  default_scope includes(:notification_type)
  
  scope :unread, where(:read => false)

  def type
    notification_type.name
  end

   def as_json(options = {})
    super(:only => [:id, :created_at, :params, :read],
          :methods => [:type])
  end
end
