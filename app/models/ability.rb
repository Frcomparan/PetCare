# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      elsif user.host?
        can [:show, :profile], User
        can [:search, :my_homes], Home
        can [:read, :create], Pet
        can [:update, :destroy], [Home, Pet] do |item| 
          item.user == user
        end
        can :read, Home
        if user.verified?
          can :create, Home
        end
      elsif user.guest?
        can [:search, :read], Home
        can [:show, :profile], User
        can :create, Pet
        can [:read, :update, :destroy], Pet do |item|
          item.user == user
        end
      end
      can [:read, :update], Reservation do |item|
        item.guest == user || item.host == user
      end
    else
      can :read, [Home, User]
      can :search, [Home]
    end
  end
end
