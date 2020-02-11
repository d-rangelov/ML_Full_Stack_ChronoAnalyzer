require "csv"
require "open-uri"

BRANDS = [
  "iwc",
  "rolex",
  "breitling",
  "omega",
  "seiko",
  "gucci",
  "movado",
  "zenith",
  "panerai",
  "cartier",
  "patekphilippe",
  "audemarspiguet",
  "jaegerlecoultre"
]

BRANDS.each do |brand|

  data = CSV.read("data/#{brand}.txt");

  data.each_with_index do |item,index|
    open(item[0]) do |image|  
      File.open("images/#{brand}-#{index+1}-#{item[1]}.jpg", "w+") do |file|
        file.write(image.read)
      end
    end
  end
end