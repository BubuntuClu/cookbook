ThinkingSphinx::Index.define :ingredient, with: :active_record do
  indexes name, sortable: true
  indexes recipe.status, as: :status, sortable: true

  has created_at, updated_at
end
