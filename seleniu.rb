require 'selenium-webdriver'

options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--headless')
driver = Selenium::WebDriver.for(:chrome, options: options)

driver.navigate.to 'https://qiita.com'

puts driver.title

elements = driver.find_elements(tag_name: 'a')
elements.each do |element|
  puts element.attribute('href')
end

driver.quit