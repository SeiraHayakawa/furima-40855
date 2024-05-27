

## users
|Column            |Type   |Options                  |
|nickname          |string |null: false, unique: true|
|email             |string |null: false              |
|encrypted_password|string |null: false              |
|family_name       |string |null: false              |
|first_name        |string |null: false              |
|family_name_kana  |string |null: false              |
|first_name_kana   |string |null: false              |
|birth_day         |date   |null: false              |

### Association
has_many :items
has_many :buyers



## items
|Column         |Type      |Options                       |
|item_name      |string    |null: false                   |
|introduction   |text      |null: false                   |
|category_id    |integer   |null: false                   |
|situation_id   |integer   |null: false                   |
|fee_id         |integer   |null: false                   |
|prefecture_id  |integer   |null: false                   |
|institution_id |integer   |null: false                   |
|price          |integer   |null: false                   |
|user           |references|null: false, foreign_key: true|

### Association
belongs_to :user
has_one :buyer



## buyers
|Column |Type   |Options                       |
|user|references|null: false, foreign_key: true|
|item|references|null: false, foreign_key: true|

### Association
belongs_to :item
belongs_to :user
has_one :address



## addresses
|Column       |Type      |Options                       |
|post_code    |string    |null: false                   |
|prefecture_id|integer   |null: false                   |
|city         |string    |null: false                   |
|address      |string    |null: false                   |
|building_name|string    |                              |
|phone_number |integer   |null: false                   |
|buyer        |references|null: false, foreign_key: true|

### Association
belongs_to :buyer


[![Image from Gyazo](https://i.gyazo.com/54862fea1cd9947d707c1343eb64095a.png)](https://gyazo.com/54862fea1cd9947d707c1343eb64095a)
