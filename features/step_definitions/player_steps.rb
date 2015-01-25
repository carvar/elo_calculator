Given(/^I visit the root page$/) do
  visit root_path
end

Given(/^I visit the new player page$/) do
  visit new_player_path
end

When(/^I click Add Player$/) do
  click_link 'Add Player'
end

Then(/^I am on the new player page$/) do
  expect(page.current_path).to eq new_player_path 
end

When(/^I enter a name and submit$/) do
  fill_in 'Name', with: 'Test'
  click_button 'Save Player'
end

Then(/^I have a player with a rating of (\d+)$/) do |rating|
  expect(Player.find_by_name('Test').rating).to eq(rating.to_i)
end