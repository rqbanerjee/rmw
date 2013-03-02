require 'capybara'
require 'capybara/dsl'
require 'yaml'

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.default_wait_time=8

class Vote
  include Capybara::DSL

  @contestant_filename
  @contestant_name
  @contestant_url

  def initialize(contestant_filename)
    if File.exists?(contestant_filename)
      @contestant_filename = contestant_filename
      process_file
    else
      raise "Could not open contestant file: #{contestant_filename}"
    end
    require 'capybara-webkit'
    Capybara.javascript_driver = :webkit if Capybara.drivers.has_key? :webkit
  end

  def process_file
    yf = YAML::load_file(@contestant_filename)
    @contestant_name = yf['contestant']['name']
    @vote_url = yf['contestant']['vote_url']
    @video_url = yf['contestant']['video_url']

    Capybara.app_host = yf['contestant']['base_url']
    puts "Voting for #{@contestant_name} at #{@contestant_url}"
  end

  def vote_once
    puts "visiting #{@video_url}"
    visit(@video_url)
    #dump
    sleep_time = 120 + rand(5)
    go_sleep(sleep_time)
    dump
    click_button('YES')
    dump
  end

  def vote_x_times(x)
    puts "will vote #{x} times"
    for i in 0..x
      vote_once
    end
    puts "done voting #{i} times"
  end

  def go_sleep(time)
    puts "sleeping for #{time} seconds"
    sleep time
    puts "done sleeping"
  end

  def dump
    puts "***************************"
    puts page.html
    puts "***************************"
    #puts page.inspect
    #puts "***************************"
  end
end