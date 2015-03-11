FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}   
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end
  factory :micropost do
    content "Lorem ipsum"
    user
  end
  factory :forum do |f|
    f.forum_title 'Test forum'
    f.description 'Lorem ipsum'
  end
  factory :forum_thread do |f|
    f.forum_thread_title "Test forum thread"
    f.forum_thread_content "Lorem ipsum"
    forum
  end
end
