# frozen_string_literal: true
class ApplicationDecorator < Draper::Decorator
  include Draper::LazyHelpers
  include ImageDecorations

  def path
    url_for object
  end
end
