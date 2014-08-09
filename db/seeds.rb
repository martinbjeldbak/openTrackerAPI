# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Track.create(name: 'Drag 400m', img_name: 'drag400',
             img_width: 20, img_height: 20, x_offset: 20, z_offset: 20)
Track.create(name: 'Drag 1000m', img_name: 'drag1000',
             img_width: 20, img_height: 20, x_offset: 20, z_offset: 20)
Track.create(name: 'Drift', img_name: 'drift',
             img_width: 20, img_height: 20, x_offset: 20, z_offset: 20)
Track.create(name: 'Imola', img_name: 'imola', img_width: 1543.89, img_height: 872.769)