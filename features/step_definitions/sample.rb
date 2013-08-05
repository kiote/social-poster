
Given(/^a two numbers$/) do
  @a = 5
  @b = 3
  @c = 7
end

When(/^I want to sum count$/) do
  @c = @b + @a
end

Then(/^its sum$/) do
  @c == 15
  Rails.logger.debug "> this"
end
