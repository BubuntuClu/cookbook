ThinkingSphinx::Index.define :recipe, with: :active_record do
  indexes title, sortable: true
  indexes status, sortable: true
  indexes user.email, as: :author, sortable: true

  has user_id, created_at, updated_at
end
