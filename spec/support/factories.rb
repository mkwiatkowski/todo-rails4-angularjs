FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "secretpassword"
  end

  factory :task_list, aliases: [:list] do
    owner

    trait :with_tasks do
      after(:create) do |task_list|
        create_list(:task, 2, list: task_list)
      end
    end
  end

  factory :task do
    list
    sequence(:description) {|n| "Task #{n}" }
  end
end
