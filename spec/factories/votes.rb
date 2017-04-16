FactoryGirl.define do
  factory :vote_up, class: "Vote" do
    value "up"
    user
    association :votable, factory: :recipe
  end
end
