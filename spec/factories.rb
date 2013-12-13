FactoryGirl.define do 
	factory :category do
		sequence(:name)  { |n| "Category #{n}" }
	end

	factory :product do
		sequence(:name)  { |n| "Product #{n}" }
		active true
		association :category,    factory: :category
	end
end