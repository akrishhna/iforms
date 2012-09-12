class StaticData < ActiveRecord::Base

  def self.service_unit
    ["Bellville", "Bluebonnet Valley", "Bosque County", "Brown County", "Bryan, College Station", "Canadian", "Central Bell", "Chisholm Trail", "Circle Tree",
     "Coke", "Coleman County", "Colorado County", "Comanche County", "Concho Pearls", "Crystal Falls", "Delco-Simond", "Double C", "Dripping Springs", "Eden",
     "Eldorado", "Elgin/McDade", "Erath County", "Flower Trails", "Forest Trails", "Fort Hood", "Fredericksburg", "Friendship", "Greater Waco", "Grimes County",
     "Grosbeck", "Hico, Hamilton", "Hill Country", "KISD", "La Grange", "Lady Bird", "Lady Bug", "Lake Austin", "Lake Hills", "Lakeline", "Lampasas County",
     "Leon County", "Little River", "Lost Pines", "Madison County", "Marlin, Rosebud/Lott, Chilton", "Mason", "McCullough County", "Melon Patch", "Menard",
     "Mertzon", "Mexia/Coolidge", "Midtown", "Mills County", "Monarch", "Mustang Valle", "Oak Hill", "Old Settlers", "PAW", "Pleasant Hill", "Red Poppy",
     "Robertson County", "Rocky Trails", "San Marcos", "San Saba County", "Somerwell", "Songbird", "Sonora", "Southern Oaks", "Southwood", "Springwoods", "Sterling",
     "Sunnyside", "Sunrise", "Texas Skies", "Texas Star", "Walnut Creek", "West Round Rock", "West", "Westlake", "Westwood", "Wildflower Trails", "Wimberley"
    ]
  end

  def self.pal
    ["Daisy", "Brownie", "Junior", "Cadette", "Senior"]
  end
end
