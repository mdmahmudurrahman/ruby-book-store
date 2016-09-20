# frozen_string_literal: true
class Authorisation < ApplicationRecord
  belongs_to :book
  belongs_to :author

  validates :book, presence: true
  validates :author, presence: true
end
