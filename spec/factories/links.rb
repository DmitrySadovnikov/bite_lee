FactoryBot.define do
  factory :link do
    original { Faker::Internet.url }
    suffix { Link.gen_suffix }
  end
end
