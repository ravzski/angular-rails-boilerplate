namespace :scrapper do

  desc "Scrape CI and CC"

  task ci_and_cc: :environment do
    puts "Time Check: #{Time.current.strftime('%Y %b %d %H:%M')}"
    puts 'Running `rake scrapper:ci_and_cc`...'
    setting = Setting.first_or_create
    setting.update_attribute(:is_scrapping, true)
    Codeclimate::Client.scrape_all
    Circleci::Client.scrape_all
    setting.update_attribute(:is_scrapping, false)
  end

end
