class StaticData < ActiveRecord::Base

  def self.service_unit
    ["Ballinger, Winters","Bellville","Bluebonnet Valley","Bosque County","Brown County","Bryan, College Station","Canadian",
      "Central Bell","Chisholm Trail","Circle Tree","Coke","Coleman County","Colorado County","Comanche County","Concho Pearls - SA, Grape Creek",
      "Crystal Falls","Delco-Simond","Double C","Dripping Springs","Eden","Eldorado","Elgin/McDade","Erath County","Flower Trails (Schlenberg/Riesel)",
      "Forest Trails","Fort Hood","Fredericksburg","Friendship","Grimes County","Grosbeck","Hico, Hamilton","Hill Country","KISD",
      "La Grange","Lady Bird","Lady Bug","Lake Austin","Lake Hills","Lakeline","Lampasas County","Leon County","Little River","Lost Pines",
      "Madison County","Marlin, Rosebud/Lott, Chilton","Mason","McCullough County","Melon Patch","Menard","Mertzon","Mexia/Coolidge",
      "Midtown","Mills County","Monarch","Mustang Valle","Oak Hill","Old Settlers","PAW","Pleasant Hill","Red Poppy","Robertson County",
      "Rocky Trails","San Marcos","San Saba County","Somerwell","Songbird","Sonora","Southern Oaks","Southwood","Springwoods","Sterling",
      "Sunnyside","Sunrise","Texas Skies","Texas Star", "Waco, China Spring, Moody/McGregor, Connally Belles, Woodlake","Walnut Creek",
      "West","West Round Rock","Westlake","Westwood","Wildflower Trails","Wimberley"]
  end

  def self.pal
    ["Daisy","Brownie","Junior","Cadette","Senior"]
  end
end
