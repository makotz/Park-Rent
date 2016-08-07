# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
parkingspots = ["73 Pittsford Victor Rd, Vancouver, BC, V5Z 3K2",
"4207 Leon Rd, North Vancouver, BC, V7L 3X6",
"6734 W Jackson Blvd, Salmon Arm, BC, V1E 4G9",
"7 Tomahawk Dr, Richmond, BC, V7A 3N1",
"2726 Franklin Hill Rd, Vernon, BC, V1T 7V8",
"77 Central Pky N, Quesnel, BC, V2J 1N4",
"9 N Central Ave, Abbotsford, BC, V2S 5R3",
"4929 Sidney St #8276, Vernon, BC, V1T 4A3",
"5 Secaucus Rd, Nanaimo, BC, V9R 5W6",
"8 J St, Vernon, BC, V1T 6J8",
"5 Columbia, North Vancouver, BC, V7J 2J9",
"41 Drive  Hwy 54s S, Vancouver, BC, V6N 3C5",
"2 Cottman Ave, West Vancouver, BC, V7T 1R7",
"283 Andover St, Castlegar, BC, V1N 3P7",
"8788 E 64th Ave, Vancouver, BC, V6R 1N3",
"82 Westminster Blvd, Vancouver, BC, V5X 2B5",
"1 Highland Ave, Maple Ridge, BC, V4R 1Z3",
"78 152nd Ave #4179, Duncan, BC, V9L 4G2",
"863 E Mcdowell Rd, Kamloops, BC, V2C 6S8",
"82 Us Highway 111, Vancouver, BC, V5X 3K2",
"491 Main St #893, Kamloops, BC, V2B 7X9",
"73 Madison Ave, Vancouver, BC, V6L 2V9",
"575 Washington St, Nanaimo, BC, V9R 6W5",
"4634 Anania Dr, Vernon, BC, V1B 3Z4",
"9 W Jackson Blvd, Surrey, BC, V3S 7P4",
"4974 Rockburn Hill Rd #3, Surrey, BC, V4A 8M9",
"62 15th Ave #63, Duncan, BC, V9L 2E9",
"20 Simpson Ferry Rd, Victoria, BC, V8Y 1H4",
"63 Baronne St, Port Moody, BC, V3H 1E8",
"7823 N 36th Ave, North Vancouver, BC, V7H 2J2",
"7 Saint Nicholas Ave, North Vancouver, BC, V7J 3P8",
"70 W Main St, Vancouver, BC, V5Z 3S8",
"7 Airway Cir, Duncan, BC, V9L 2T9",
"7 Ryan Industrial Ct, Vancouver, BC, V6H 3Y2",
"7 Mccrea St, Chilliwack, BC, V2P 6L6",
"80 Sw End Blvd, Surrey, BC, V3R 4L7",
"250 University Ave #9, Comox, BC, V9M 1T4",
"5181 N Alma School Rd, Dawson Creek, BC, V1G 1Y2",
"1 Sw 72nd Ave, Chilliwack, BC, V2P 4W3",
"8939 Merrill Field Dr, Burnaby, BC, V5G 4J9",
"84 L St #98, Coquitlam, BC, V3E 2W1",
"440 Town Center Dr, Kamloops, BC, V2B 7W6",
"637 Wright Rd, Coquitlam, BC, V3K 2P4",
"1 Highway 71 S, Abbotsford, BC, V2S 2G5",
"809 W Bayshore Rd, Trail, BC, V1R 4Y2",
"87 Via Contenta, West Kelowna, BC, V1Z 2J2",
"48 Market St, Prince George, BC, V2M 1K4",
"1458 W Henry St, Nelson, BC, V1L 1A7",
"3878 Little John Way, Salt Spring Island, BC, V8K 2T5",
"5 Middletown Blvd, Richmond, BC, V6Y 1L9",
"8 General Dr, Nanaimo, BC, V9R 4Z4",
"7635 Run Subdivision, Surrey, BC, V3X 2L5",
"41 Augusta Hwy, Richmond, BC, V6X 3S2",
"985 Joyce St, Surrey, BC, V3R 4T5",
"71 Linden Ave, Surrey, BC, V3W 9G2",
"9 Park St, Chilliwack, BC, V2P 3X4",
"92 A Glenneyre Ave, Cranbrook, BC, V1C 4E3",
"71 S Newtown St, North Vancouver, BC, V7M 3J6",
"5094 Poway Rd, Vancouver, BC, V5X 4K1",
"66 62nd St #30, Surrey, BC, V3R 6N7"]

events = ["19 Torresdale Ave #58, Victoria, BC, V8X 1R2",
"128 W Kellogg Dr, Burnaby, BC, V5B 4L5",
"7 Shetland Ct, Kimberley, BC, V1A 2M7",
"2863 Brooklyn Terminal Mkt, Abbotsford, BC, V2S 4M2",
"6059 Alewa Dr, Surrey, BC, V3X 1X5",
"5470 N Lamar Blvd #542, North Vancouver, BC, V7J 2J9",
"4153 Broughton Ave, Victoria, BC, V9A 6P6",
"5 Falls Rd, Victoria, BC, V8V 2P7",
"865 N Port Ave, Coquitlam, BC, V3E 1Y4",
"78 E River, Surrey, BC, V4P 0C4",
"123 Euclid Ave #9396, Nanaimo, BC, V9R 1C9",
"9 Route 38, Port Coquitlam, BC, V3C 2Z4"]



puts "delete_all data"

Parkingspot.delete_all
Event.delete_all
User.delete_all

puts "creating 40 users"

40.times do
    a = Faker::Name.first_name
    User.create(first_name: a, last_name: Faker::Name.last_name, email: "#{a}@gmail.com", password_digest:"mako1219")
end

puts "created 40 users"

puts "creating 60 parkingspots"
  parkingspots.each do |x|
    a  = User.order("RANDOM()").first
    Parkingspot.create(address: x, default_price: rand(0.1..3), user: a, title: a.first_name, notification: true)
  end

puts "created 60 parkingspots"

puts "creating 12 events"
  events.each do |x|
    a  = User.order("RANDOM()").first
    Event.create(address: x, suggested_price: rand(2..4), user: a, starttime: Faker::Time.between(DateTime.now + 6, DateTime.now + 7 ), endtime: Faker::Time.between(DateTime.now + 7, DateTime.now + 8), title: "#{a.first_name}'s party!", description: "Come out for a great time!")
  end

puts "created 12 events"
