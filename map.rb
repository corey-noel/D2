class Map

  attr_reader :start

  def initialize
    sutter_creek = City.new("Sutter Creek", 0, 2)
    coloma = City.new("Coloma", 0, 3)
    angels_camp = City.new("Angels Camp", 0, 4)
    nevada_city = City.new("Nevada City", 0, 5)
    virginia_city = City.new("Virginia City", 3, 3)
    midas = City.new("Midas", 5, 0)
    el_dorado_canyon = City.new("El Dorado Canyon", 10, 0)

    sutter_creek.connect(coloma)
    sutter_creek.connect(angels_camp)
    coloma.connect(virginia_city)
    angels_camp.connect(nevada_city)
    angels_camp.connect(virginia_city)
    virginia_city.connect(midas)
    virginia_city.connect(el_dorado_canyon)
    midas.connect(el_dorado_canyon)

    @cities = [sutter_creek, coloma, angels_camp, nevada_city,
    virginia_city, midas, el_dorado_canyon]

    @start = sutter_creek
  end
end
