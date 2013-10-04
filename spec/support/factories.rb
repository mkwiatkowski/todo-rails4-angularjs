FactoryGirl.define do
  factory :user, aliases: [:owner] do
    sequence(:email) {|n| "user#{n}@example.com" }
    password "secretpassword"
  end

  factory :task_list, aliases: [:list] do
    owner
    name "My First List"
  end

  factory :task do
    list
    sequence(:description) {|n| "Task #{n}" }
  end
end
