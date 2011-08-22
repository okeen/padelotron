module Statable
  extend ActiveSupport::Concern

  included do
    has_one :stat, :as => :statable
    has_many :achievements, :through => :stat

    after_create :create_statistics
  end

  module ClassMethods
  
  end

  module InstanceMethods

    private

    def create_statistics
      create_stat.save
    end
  end

end