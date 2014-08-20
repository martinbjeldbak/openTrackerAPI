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
Track.create(name: 'Imola', img_name: 'imola', img_width: 1543.89, img_height: 872.769,
             x_offset: 955.115, z_offset: 536.043, scale_factor: 1.2, img_scale: 0.5)
Track.create(name: 'Magione', img_name: 'magione', img_height: 861.583, img_width: 342.88,
             x_offset: 187.289, z_offset: 444.422)
Track.create(name: 'Monza', img_name: 'monza', img_height: 1575.82, img_width: 927.422,
             x_offset: 232.866, z_offset: 1297.7, scale_factor: 1.4, img_scale: 0.25)
Track.create(name: 'Monza 1966', img_name: 'monza66', img_height: 1584.01, img_width: 934.647,
             x_offset: 230.455, z_offset: 1310.29, scale_factor: 1.4)
Track.create(name: 'Mugello', img_name: 'mugello', img_height: 627.674, img_width: 1495.89,
             x_offset: 796.459, z_offset: 314.943, img_scale: 0.5)
Track.create(name: 'Nurburgring', img_name: 'nurburgring', img_height: 1567.66, img_width: 601.503,
             x_offset: 423.288, z_offset: 1037.29, scale_factor: 1.2, img_scale: 0.4)
Track.create(name: 'Silverstone', img_name: 'silverstone', img_height: 1466.72, img_width: 876.844,
             x_offset: 530.08, z_offset: 88.431, scale_factor: 1.2, img_scale: 0.5)
Track.create(name: 'Silverstone-International', img_name: 'silverstone-international', img_height: 1040.5, img_width: 961.299,
             x_offset: 528.261, z_offset: 167.886)
Track.create(name: 'Vallelunga', img_name: 'vallelunga', img_height: 514.88, img_width: 1277.07,
             x_offset: 697.106, z_offset: 201.341)
Track.create(name: 'Vallelunga-club', img_name: 'vallelunga-club', img_height: 256.251, img_width: 599.505,
             x_offset: 20, z_offset: 20)