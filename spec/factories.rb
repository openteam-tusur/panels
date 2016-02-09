FactoryGirl.define do

  sequence :user_id do |n|
    "user_#{n}"
  end

  factory :permission, class: Permission do
    user_id

    trait :admin do
      role :admin
    end

  end
end
