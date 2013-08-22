FactoryGirl.define do
  factory :user, aliases: [:owner] do
    email "user@example.com"
    password "secretpassword"
  end

  factory :task_list do
    owner
  end
end
