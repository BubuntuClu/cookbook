class Search
  TYPES = %w(recipe ingredient user).freeze

  class << self
    def run(type, search)
      return [] unless TYPES.include?(type)

      request = ThinkingSphinx::Query.escape(search.to_s)

      case type
      when 'user'
        results = User.search conditions: { email: request }
      when 'ingredient'
        results = Ingredient.search conditions: { name: request, status: Recipe.statuses[:published] }
        results = results.map(&:recipe)
      else
        results = Recipe.search conditions: { title: request, status: Recipe.statuses[:published] }
      end
      results
    end
  end
end
