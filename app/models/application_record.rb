# frozen_string_literal: true
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def label
    "#{self.class} ##{id}"
  end
end
