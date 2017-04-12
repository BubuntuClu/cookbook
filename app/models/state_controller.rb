class StateController 

  class << self

    def change_status(recipe_id, action, comment = nil)
      recipe = Recipe.find(recipe_id)
      if action == 'send_to_moderation'
        recipe.update_attributes(status: :moderation) 
        return
      end

      if action == 'send_to_publish'
        recipe.comments.destroy_all
        recipe.update_attributes(status: :published) 
        return 
      end

      if action == 'send_to_draft'
        recipe.comments.create(body: comment[:body])
        recipe.update_attributes(status: :draft) 
        return
      end
    end
  end
end
