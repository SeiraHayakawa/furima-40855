FactoryBot.define do
  factory :buyer_address do
    post_code { '108-0073' }  
    prefecture_id { 2 }  
    city { '港区' }  
    address { '三田1-6-3' }  
    building_name { 'シティータワー麻布十番2107' }  
    phone_number { '09832727654' }  
    token {"tok_abcdefghijk00000000000000000"}

  end
end
