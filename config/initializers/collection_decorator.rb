# frozen_string_literal: true
class Draper::CollectionDecorator
  delegate :current_page, :total_pages, :total_count, :limit_value
end
