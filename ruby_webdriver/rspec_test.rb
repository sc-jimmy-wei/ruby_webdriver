require "selenium-webdriver"
require "./page_element.rb"
require "page-object"

describe "Fitness Tracker" do

	before(:all) do
		@driver = Selenium::WebDriver.for :firefox
		@driver.manage.window.maximize
		# @driver.navigate.to ("localhost:3000")
		@wait = Selenium::WebDriver::Wait.new(:timeout => 15)
	end
	
	after(:all) do
		@driver.quit
	end

	it "load home page" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.home_title}
		expect(home_page.home_title == "Welcome to Fitness Tracker").to be true
	end

	it "load home page picture" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.baby_pic_element}
		expect(home_page.baby_pic_element.visible?).to be true
	end

	it "load sign up page" do
		home_page = HomePage.new(@driver)
		home_page.goto
		@wait.until {home_page.sign_up_link_element}
		home_page.sign_up_link
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.sign_up_title}
		expect(sign_up_page.sign_up_title == "Sign up").to be true
	end

	it "test sign up flow" do
		home_page = HomePage.new(@driver)
		home_page.goto
		home_page.sign_up_link_element.when_visible.click
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.first_name?}
		sign_up_page.first_name = sign_up_page.generate_random_string
		find_xpath = "//*[contains(text(), \'%s\')]" % [sign_up_page.first_name]
		@wait.until {sign_up_page.last_name?}
		sign_up_page.last_name = sign_up_page.generate_random_string
		sign_up_page.check_metric
		sign_up_page.height = sign_up_page.generate_random_number
		sign_up_page.weight = sign_up_page.generate_random_number
		sign_up_page.temperature = sign_up_page.generate_random_number
		sign_up_page.create_button
		home_page.show_all_babies_link_element.when_visible.click
		baby_index_page = BabyIndexPage.new(@driver)
		@wait.until {baby_index_page.baby_index_table?}
		test_baby = @driver.find_element(:xpath, find_xpath)
		expect(test_baby.displayed?).to be true
	end

	it "check if sign up data are saved" do
		home_page = HomePage.new(@driver)
		home_page.goto
		home_page.sign_up_link_element.when_visible.click
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.first_name?}
		sign_up_page.first_name = sign_up_page.generate_random_string
		tester_first_name = sign_up_page.first_name
		find_first_name_xpath = "//*[contains(text(), \'%s\')]" % [sign_up_page.first_name]
		@wait.until {sign_up_page.last_name?}
		sign_up_page.last_name = sign_up_page.generate_random_string
		tester_last_name = sign_up_page.last_name
		sign_up_page.check_metric
		sign_up_page.height = sign_up_page.generate_random_number
		tester_height = sign_up_page.height
		sign_up_page.weight = sign_up_page.generate_random_number
		tester_weight = sign_up_page.weight
		sign_up_page.temperature = sign_up_page.generate_random_number
		tester_temperature = sign_up_page.temperature
		sign_up_page.create_button
		home_page.show_all_babies_link_element.when_visible.click
		baby_index_page = BabyIndexPage.new(@driver)
		@wait.until {baby_index_page.baby_index_table?}
		tester_baby = @driver.find_element(:xpath, find_first_name_xpath)
		tester_baby.click
		baby_detail_page = BabyDetailPage.new(@driver)
		@wait.until {baby_detail_page.baby_temperature?}
		expect(baby_detail_page.baby_first_name).to eq(tester_first_name)
		expect(baby_detail_page.baby_last_name).to eq(tester_last_name)
		expect(baby_detail_page.baby_height).to eq(tester_height)
		expect(baby_detail_page.baby_weight).to eq(tester_weight)
		expect(baby_detail_page.baby_temperature).to eq(tester_temperature)
	end

	it "checks conversion" do
		home_page = HomePage.new(@driver)
		home_page.goto
		home_page.sign_up_link_element.when_visible.click
		sign_up_page = SignUpPage.new(@driver)
		@wait.until {sign_up_page.first_name?}
		sign_up_page.first_name = sign_up_page.generate_random_string
		tester_first_name = sign_up_page.first_name
		find_first_name_xpath = "//*[contains(text(), \'%s\')]" % [sign_up_page.first_name]
		@wait.until {sign_up_page.last_name?}
		sign_up_page.last_name = sign_up_page.generate_random_string
		sign_up_page.check_metric
		sign_up_page.height = sign_up_page.generate_random_number
		sign_up_page.weight = sign_up_page.generate_random_number
		sign_up_page.temperature = sign_up_page.generate_random_number
		sign_up_page.create_button
		home_page.show_all_babies_link_element.when_visible.click
		baby_index_page = BabyIndexPage.new(@driver)
		@wait.until {baby_index_page.baby_index_table?}
		tester_baby = @driver.find_element(:xpath, find_first_name_xpath)
		tester_baby.click
		baby_detail_page = BabyDetailPage.new(@driver)
		@wait.until {baby_detail_page.baby_temperature?}
		tester_metric_height = baby_detail_page.baby_height.to_f
		tester_metric_weight = baby_detail_page.baby_weight.to_f
		tester_metric_temperature = baby_detail_page.baby_temperature.to_f
		tester_imperial_height = baby_detail_page.centimeter_to_inch(tester_metric_height)
		tester_imperial_weight = baby_detail_page.kilogram_to_pound(tester_metric_weight)
		tester_imperial_temperature = baby_detail_page.celsius_to_fahrenheit(tester_metric_temperature)
		baby_detail_page.imperial_link
		@driver.navigate.refresh
		@wait.until {baby_detail_page.baby_temperature?}
		expect(baby_detail_page.baby_height.to_f == tester_imperial_height).to be true
		expect(baby_detail_page.baby_weight.to_f == tester_imperial_weight).to be true
		expect(baby_detail_page.baby_temperature.to_f == tester_imperial_temperature).to be true
	end

end