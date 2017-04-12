FactoryGirl.define do
  factory :recipe do
    title "My testing title"
    description "My testing description"
  end

  factory :moderation_recipe, class: "Recipe" do
    title "this is moderation_recipe"
    description "some description text here"
    status 1
  end

  factory :published_recipe, class: "Recipe" do
    title "this is published recipe"
    description "some description text here"
    status 2
  end

  factory :draft_recipe, class: "Recipe" do
    title "this is  draft recipe"
    description "some description text here"
    status 0
  end
end
