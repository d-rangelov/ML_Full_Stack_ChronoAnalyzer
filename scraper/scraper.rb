require "nokogiri"
require "watir"

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


browser = Watir::Browser.new(:chrome)

BRANDS.each do |brand|
  urls = [
    "https://www.chrono24.com/#{brand}/index.htm",
    "https://www.chrono24.com/#{brand}/index-2.htm",
    "https://www.chrono24.com/#{brand}/index-3.htm",
    "https://www.chrono24.com/#{brand}/index-4.htm",
    "https://www.chrono24.com/#{brand}/index-5.htm"
  ]

  urls.each do |url|

    browser.goto(url)
    # Sleep so that we can download initial images
    sleep 2
      15.times do |i|
        browser.execute_script("window.scrollBy(0,500)")
        # Sleep again to give time for the images to load
        sleep 1
      end
      doc = Nokogiri::HTML.parse(browser.html)

      # Div containers for each watch
      article_divs = doc.css(".article-item-container")
    
      # Get the image url for each watch
      article_divs.each do |article_div|
        image_div = article_div.at_css(".article-image-container .content img")
        price_text = article_div.at_css(".article-price strong").text
        next if !image_div || !price_text
    
        image_url = image_div['src']
        price = price_text.gsub(/[^0-9]/,"")
    
        next if image_url.empty? || price.empty?
    
        File.open("data/#{brand}.txt", "a+") do |f|
          f.puts("#{image_url},#{price}")
        end
      end 
    end  
end