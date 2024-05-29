FactoryBot.define do
  factory :item do
    item_name { "Sample Item" }
    introduction { "This is a sample item." }
    category_id { 2 }  
    situation_id { 2 } 
    fee_id { 2 }       
    prefecture_id { 2 }
    institution_id { 2 } 
    price { 1000 }    
    association :user 
    
    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
