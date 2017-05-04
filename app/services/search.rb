class Search
  TYPES = %w(recipe ingredient).freeze

  class << self
    def run(type, search)
      return [] unless TYPES.include?(type)

      request = ThinkingSphinx::Query.escape(search.to_s)

      search_field = "title".to_sym
      if type == 'recipe'
        results = Recipe.search conditions: { title: request, status: Recipe.statuses[:published] }
      else
        results = Ingredient.search conditions: { name: request, status: Recipe.statuses[:published] }
        results = results.map(&:recipe)
      end
      results
    end
  end
end
