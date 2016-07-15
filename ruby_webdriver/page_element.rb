require "selenium-webdriver"
require "page-object"

#https://github.com/cheezy/page-object/wiki/Elements
#gem page object element

#http://www.rubydoc.info/github/cheezy/page-object/PageObject

class HomePage
	include PageObject
	page_url("http://localhost:3000")

	#define elements in HOME PAGE
	h1(:home_title, :xpath => '//*[@id="page-content-wrapper"]/div/div/div/h1')
	image(:baby_pic, :alt => 'Happy baby')
	link(:sign_up_link, :href => 'babies/new')
	link(:show_all_babies_link, :href => 'babies')
	#define functions used in HOME PAGE
	
end

class SignUpPage
	include PageObject
	page_url("http://localhost:3000/babies/new")

	#define elements in SIGN UP PAGE
	h1(:sign_up_title, :xpath => '/html/body/h1')
	text_field(:first_name, id: 'baby_first_name')
	text_field(:last_name, :id => 'baby_last_name')
	checkbox(:metric, :id => 'baby_metric')
	text_field(:height, :id => 'baby_height')
	text_field(:weight, :id => 'baby_weight')
	text_field(:temperature, :id => 'baby_temperature')
	button(:create_button, :value => 'Create Baby')

	#define functions used in SIGN UP PAGE
	def generate_random_string()
		randomString = [*('A'..'Z'), *('a'..'z')].sample(8).join
		randomString
	end

	def generate_random_number()
		random_number = [*('0'..'99')].sample(1).join
		random_number
	end

end

class BabyIndexPage
	include PageObject
	page_url("http://localhost:3000/babies")

	#define elements in BABY INDEX PAGE
	h1(:baby_index_title, :xpath => '/html/body/h1')
	table(:baby_index_table, :xpath => '/html/body/table')

	#define functoins used in BABY INDEX PAGE

end

class BabyDetailPage
	include PageObject
	page_url("")

	#define elements in BABY DETAIL PAGE
	paragraph(:baby_first_name, :css => 'p:nth-child(1) > strong:nth-child(1)')
	paragraph(:baby_last_name, :css => 'p:nth-child(1) > strong:nth-child(2)')
	paragraph(:baby_height, :css => 'p:nth-child(2) > strong:nth-child(2)')
	paragraph(:baby_weight, :css => 'p:nth-child(2) > strong:nth-child(4)')
	paragraph(:baby_temperature, :css => 'p:nth-child(2) > strong:nth-child(6)')
	link(:home_page_link, :href => '/')
	link(:metric_link, :css => 'h3 > b > a:nth-child(1)')
	link(:imperial_link, :css => 'h3 > b > a:nth-child(2)')

	#define functions used in BABY DETAIL PAGE
  	CENTIMETER = 1
  	METER = 100 * 1
  	INCH = 2.54 * 1
  	FOOT = 12 * 2.54 * 1
  	YARD = 3 * 12 * 2.54 * 1
  	MILE = 1760 * 3 * 12 * 2.54 * 1

  	KILOGRAM = 1
  	POUND = 2.2 * 1

	def inch_to_centimeter(value)
    	(value * BabyDetailPage::INCH).round(2)
  	end

  	def centimeter_to_inch(value)
    	(value / BabyDetailPage::INCH).round(2)
  	end

  	def kilogram_to_pound(value)
    	(value * BabyDetailPage::POUND).round(2)
  	end

  	def pound_to_kilogram(value)
    	(value / BabyDetailPage::POUND).round(2)
  	end

  	def celsius_to_fahrenheit(value)
    	((value * 9/5) + 32).round(1)
  	end

  	def fahrenheit_to_celsius(value)
    	self.value = ((value - 32) * 5/9).round(1)
  	end
end