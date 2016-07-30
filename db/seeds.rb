# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

eventArray = ["2335 Canton Hwy #6, Windsor, ON, N8N 3N2",
"6 Arch St #9757, Alcida, NB, E8J 2C4",
"9547 Belmont Rd #21, Belleville, ON, K8P 1B3",
"73 Pittsford Victor Rd, Vancouver, BC, V5Z 3K2",
"447 Commercial St Se, LIle-Perrot, QC, J7V 4T4",
"47 Garfield Ave, Swift Current, SK, S9H 4V2",
"3 Mill Rd, Baker Brook, NB, E7A 1T3",
"136 W Grand Ave #3, Delhi, ON, N4B 1C4",
"80 Maplewood Dr #34, Bradford, ON, L3Z 2S4",
"58 Hancock St, Aurora, ON, L4G 2J7",
"808 Calle De Industrias, New Waterford, NS, B1H 1Z4",
"2859 Dorsett Rd, North York, ON, M9L 2T9",
"6857 Wall St, Red Deer, AB, T4R 2H5",
"169 Journal Sq, Edmonton, AB, T5P 1G9",
"3 E 31st St #77, Fredericton, NB, E3G 0A3",
"7 N Dean St, Etobicoke, ON, M8Z 3P6",
"85 S State St, Barrie, ON, L4N 6T7",
"100 Main St, Calgary, AB, T2K 4X5",
"6185 Bohn St #72, Pangman, SK, S0C 2C0",
"2 Sutton Pl S #5727, Rouyn-Noranda, QC, J9X 3V4",
"781 Alabama Ave, Etobicoke, ON, M8Z 2C1"]

addressArray = [
"26659 N 13th St, Costa Mesa, Orange, CA",
"669 Packerland Dr #1438, Denver, Denver, CO",
"759 Eldora St, New Haven, New Haven, CT",
"5 S Colorado Blvd #449, Bothell, Snohomish, WA",
"944 Gaither Dr, Strongsville, Cuyahoga, OH",
"66552 Malone Rd, Plaistow, Rockingham, NH",
"77 Massillon Rd #822, Satellite Beach, Brevard, FL",
"25346 New Rd, New York, New York, NY",
"60 Fillmore Ave, Huntington Beach, Orange, CA",
"57 Haven Ave #90, Southfield, Oakland, MI",
"6538 E Pomona St #60, Indianapolis, Marion, IN",
"6535 Joyce St, Wichita Falls, Wichita, TX",
"78112 Morris Ave, North Haven, New Haven, CT",
"96950 Hidden Ln, Aberdeen, Harford, MD",
"3718 S Main St, New Orleans, Orleans, LA",
"9677 Commerce Dr, Richmond, Richmond City, VA",
"5 Green Pond Rd #4, Southampton, Bucks, PA",
"636 Commerce Dr #42, Shakopee, Scott, MN",
"42744 Hamann Industrial Pky #82, Miami, Miami-Dade, FL",
"1950 5th Ave, Milwaukee, Milwaukee, WI",
"61304 N French Rd, Somerset, Somerset, NJ",
"87 Imperial Ct #79, Fargo, Cass, ND",
"94 W Dodge Rd, Carson City, Carson City, NV",
"4 58th St #3519, Scottsdale, Maricopa, AZ",
"5221 Bear Valley Rd, Nashville, Davidson, TN",
"9648 S Main, Salisbury, Wicomico, MD",
"7 S San Marcos Rd, New York, New York, NY",
"812 S Haven St, Amarillo, Randall, TX",
"3882 W Congress St #799, Los Angeles, Los Angeles, CA",
"4 E Colonial Dr, La Mesa, San Diego, CA",
"45 2nd Ave #9759, Atlanta, Fulton, GA",
"57254 Brickell Ave #372, Worcester, Worcester, MA",
"8977 Connecticut Ave Nw #3, Niles, Berrien, MI",
"9 Waydell St, Fairfield, Essex, NJ",
"43 Huey P Long Ave, Lafayette, Lafayette, LA",
"7563 Cornwall Rd #4462, Denver, Lancaster, PA",
"22 Bridle Ln, Valley Park, Saint Louis, MO",
"61556 W 20th Ave, Seattle, King, WA",
"63 E Aurora Dr, Orlando, Orange, FL"]

puts "Creates 3 Users"

u1 = User.create(first_name: 'Salmon', last_name: 'S',
              email: 'salmon@gmail.com', password: 'mako1219',
              password_confirmation: 'mako1219')
u2 = User.create(first_name: 'Kahlil', last_name: 'K',
              email: 'kahlil@gmail.com', password: 'mako1219',
              password_confirmation: 'mako1219')
u3 = User.create(first_name: 'Kenan', last_name: 'K',
              email: 'kenan@gmail.com', password: 'mako1219',
              password_confirmation: 'mako1219')

allUsers = User.all

puts "Create Parkingspots"

addressArray.each do |address|
  Parkingspot.create(address: address, user: allUsers.sample, title: Faker::Commerce.product_name, description: Faker::Lorem.sentence)
end

puts "Create Events"

eventArray.each do |event|
  counter = 1
  Event.create(address: event, user: allUsers.sample, title: Faker::Commerce.product_name, description: Faker::Lorem.sentence, start: Faker::Time.between(counter.days.ago, counter.days.ago, :morning), end: Faker::Time.between(counter.days.ago, counter.days.ago, :evening))
  counter += 1
end
