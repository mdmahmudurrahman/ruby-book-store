# frozen_string_literal: true
class AuthorDecorator < ApplicationDecorator
  delegate_all

  decorates_association :books

  def fullname
    "#{firstname} #{lastname}"
  end

  def description
    simple_format author.description
  end

  def link
    link_to fullname, path
  end
end
