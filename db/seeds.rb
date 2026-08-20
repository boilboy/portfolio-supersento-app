# frozen_string_literal: true

Review.destroy_all
Facility.destroy_all

user = User.find_by(email: 'riku98@gmail.com') || User.create!(
  email: 'test1@example.com',
  password: 'password123',
  nickname: 'サウナマン'
)

facility1 = Facility.create!(name: 'スパメッツァおおたか 竜泉寺の湯', address: '千葉県 流山市',
                             introduction: '室内には、ドラゴンサウナという大きなサウナ室があります。中は暗くテレビもなくゆっくり過ごしたい方にはおすすめの施設となっております。岩盤浴も別料金になりますが、たくさんの書籍と6種の岩盤浴やコワーキング設備やソファなどあり、快適に過ごせます。')
facility2 = Facility.create!(name: '東京豊洲 万葉倶楽部', address: '東京都 江東区',
                             introduction: '箱根と湯河原の温泉を毎日運ぶ24時間営業の温泉施設です。東京湾や360度の夜景が楽しめる展望足湯庭園が魅力です。')
facility3 = Facility.create!(name: 'RAKU SPA 1010 神田', address: '東京都 千代田区',
                             introduction: '当施設では都心のオアシス的存在となっており、100度のドライサウナと水風呂があり、荷物を預けて皇居ランなどに出かけられるなど立地の良さを生かした魅力的な施設となっております。')
facility4 = Facility.create!(name: '湯乃泉 草加健康センター', address: '埼玉県 草加市',
                             introduction: '薬草風呂があり、温泉の効能を気にする方にとっては、とてもいい選択肢になると思われます。サウナの見どころとしては、アウフグースイベントやブロワーを使ったロウリュなど整うための魅力的なイベントがたくさんあります。')
facility5 = Facility.create!(name: 'ROOFTOP', address: '東京都 杉並区',
                             introduction: 'まさにサウナに特化した施設であり、整うために外気浴の倒して整えるチェアが複数あります。スーパー銭湯によくある湯船がない点には注意が必要になります。')

Review.create!(
  user: user,
  facility: facility1,
  body: 'ドラゴンサウナのロウリュが強烈で最高でした！清潔感もあって大満足です。',
  cleanliness_rating: 5.0,
  relaxation_rating: 4.5,
  bedrock_bath_rating: 4.5,
  food_rating: 3.5,
  rest_space_rating: 4.5,
  service_rating: 4.0
)

Review.create!(
  user: user,
  facility: facility2,
  body: '温泉からお湯を運んでくることもあり、泉質もいいと思います。景色もよくまた来たいです!',
  cleanliness_rating: 4.5,
  relaxation_rating: 4.0,
  bedrock_bath_rating: 4.0,
  food_rating: 4.0,
  rest_space_rating: 4.5,
  service_rating: 4.5
)

Review.create!(
  user: user,
  facility: facility3,
  body: '漫画、アニメ、オタク向けタイアップなどもあり、推し活にも向いていて、なかなかの幸せ空間でした。',
  cleanliness_rating: 4.5,
  relaxation_rating: 4.0,
  bedrock_bath_rating: 4.5,
  food_rating: 3.5,
  rest_space_rating: 4.0,
  service_rating: 4.5
)

Review.create!(
  user: user,
  facility: facility4,
  body: '整うために工夫された色々な試みがあり、施設は少し築年数が経っていそうですが、清掃は行き届いていて、古き良き温浴施設だと思います。',
  cleanliness_rating: 4.0,
  relaxation_rating: 3.5,
  food_rating: 5.0,
  rest_space_rating: 4.0,
  service_rating: 4.0
)

Review.create!(
  user: user,
  facility: facility5,
  body: '湯船はありませんが、サウナ室の温度と外気浴スペースの充実度は都内屈指です。',
  cleanliness_rating: 5.0,
  relaxation_rating: 3.5,
  food_rating: 4.0,
  rest_space_rating: 4.5,
  service_rating: 4.0
)
