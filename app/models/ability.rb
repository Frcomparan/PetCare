# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user 
      if user.admin?
        can :manege, :all
      elsif user.host?
        # Home
        can [:read, :create], [Home, Pet]
        can [:update, :destroy], Home do |item| 
          item.user == user
        end

        can [:update, :destroy], Pet do |item| 
          item.user == user
        end
      elsif user.guest?
        can :read, Home
        can :create, Pet
        can [:read, :update, :destroy], Pet do |item|
          item.user == user
        end
      end
    end
  end
end
