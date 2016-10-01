# frozen_string_literal: true
class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if user.try :admin?
      admin_abilities
    elsif user
      user_abilities
    else
      guest_abilities
    end
  end

  private

  def guest_abilities
    can :read, Author
    can :read, Category
    can :read, Book.visible
  end

  def user_abilities
    guest_abilities
    can :read, :setting
    can :read, Order, user_id: @user.id
  end

  def admin_abilities
    can :manage, :all
    can :access, :rails_admin
  end
end
