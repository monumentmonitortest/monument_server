# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Site.create([
  {
    name: "Machrie Moor Standing Circles",
    latitude: 55.5575703,
    longitude: -5.357919614,
    pic_id: "PIC092",
    visits: 12,
    visitors: 40000
  },
  {
    name: "Ness of Burgi",
    latitude: 59.8596424,
    longitude: 1.3279295,
    pic_id: "PIC259",
    visits: 4,
    visitors: 1000
  }
])

Type.create([
  {
    name: "Instagram"
  },
  { 
    name: "Whatsapp"
  },
  {
    name: "Email"
  },
  { 
    name: "Twitter"
  }
])