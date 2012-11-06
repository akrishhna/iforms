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

  def self.diamond_activity_state
    ['AL','AK','AS','AZ','AR','CA','CO','CT','DE','DC','FM','FL','GA','GU','HI','ID','IL','IN','IA','KS','KY','LA','ME','MH','MD',
     'MA','MI','MN','MS','MO''MT','NE','NV','NH','NJ','NM','NY','NC','ND','MP','OH','OK','OR','PW','PA','PR','RI','SC','SD','TN',
     'TX','UT','VT','VI','VA','WA','WV','WI','WY']
  end

  def self.sign_up_service_type
    [['Central Texas','2'],['Diamonds of AR, OK, and TX','3']]
  end
end
