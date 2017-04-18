class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user
      user.admin ? admin_ablities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    common_abilities
    can :set_to_moderation, Recipe, user_id: @user.id
    cannot :set_to_publish, Recipe
    cannot :set_to_draft, Recipe
  end

  def admin_ablities
    common_abilities
    cannot :set_to_moderation, Recipe
    can :set_to_publish, Recipe
    can :set_to_draft, Recipe
  end

  def common_abilities
    can :manage, [Recipe, Ingredient, Comment, Vote]
    can :manage, Attachment, attachemntable: { user_id: @user.id }
  end

end
