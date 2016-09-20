# frozen_string_literal: true
class Author < ApplicationRecord
  ###=> associations

  has_many :authorisations

  has_many :books, through: :authorisations,
                   dependent: :restrict_with_error

  ###=> delegates

  delegate :visible, to: :books, prefix: true

  ###=> validations

  validates :firstname, :lastname, presence: true

  ###=> methods

  def label
    decorate.fullname
  end
end
