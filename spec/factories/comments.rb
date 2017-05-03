FactoryGirl.define do
  factory :comment do
    body "Comment from admin"
    by_admin true
  end

  factory :user_comment, class: "Comment" do
    body "Comment from user"
    by_admin false
  end
end
