require "selenium-webdriver"
require "./page_element.rb"
require "page-object"

@driver = Selenium::WebDriver.for :firefox
@driver.manage.window.maximize
@wait = Selenium::WebDriver::Wait.new(:timeout => 15)

home_page = HomePage.new(@driver)
home_page.goto
@wait.until {home_page.home_title}

if home_page.home_title == "Welcome to Fitness Tracker"
	puts "Page loaded"
else
	puts "Page didn't load"
end

@driver.quit