require 'open-uri'
require 'nokogiri'
require 'json'
require 'csv'

require 'open-uri'

url = 'https://www.goodhousekeeping.com/life/entertainment/g34931305/best-books-2021/'
html = URI.open(url){ |result| result.read }
doc = Nokogiri::HTML(html)

books = []
books = doc.css('.listicle-slide').map do |book|
    { 
        rating: book.css('.listicle-slide-hed-number').text.to_i,
        title: book.css('.listicle-slide-hed-text').text,
        author: book.css('.product-slide-brand').text,
        vendor: book.css('.product-slide-vendor').text,
        price: book.css('.list-price').text,
        description: book.css('.slideshow-slide-dek').text
    }
end

#puts books

#table_headers = []
#table_headers = ["Rating","Title","Author","Vendor","Price","Description"]


CSV.open('Books.csv', 'w') do |csv|

    books.each { |b| csv << b.values }
end