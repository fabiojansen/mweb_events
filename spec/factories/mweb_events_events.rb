# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event, :class => MwebEvents::Event do |e|
    e.sequence(:name) { Faker::Name.name }
    e.permalink { name.split.join('-') }
    e.description { Faker::Lorem.paragraph }
    e.summary { Faker::Lorem.characters 140 }
    e.time_zone { Faker::Address.time_zone }
    e.location { Faker::Name.name }
    e.address { Faker::Address.street_address }
    e.social_networks { MwebEvents::SOCIAL_NETWORKS.sample(3) }
    e.start_on { Time.now + 2.hours }
    e.end_on { Time.now + 4.hours }
    # e.association :owner, :factory => :user
  end
end

