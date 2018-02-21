require 'rails_helper'

feature 'A user sees if a word is vaild or not' do

  before(:each) do
    visit '/'
  end

  describe 'a valid word' do
    it "returns that the word is valid and the root form" do
      page.fill_in 'Word', with: 'foxes'
      click_on 'Validate Word'

      expect(page).to have_content "'foxes' is a valid word and its root form is 'fox'."
    end
  end

  describe 'an invalid word' do
    it "returns that the word is invalid" do
      page.fill_in 'Word', with: 'foxez'
      click_on 'Validate Word'

      expect(page).to have_content "'foxez' is not a valid word."
    end
  end
end

# Background:
# * This story should use the Oxford Dictionaries API https://developer.oxforddictionaries.com/documentation
# * Use endpoint "GET /inflections/{source_lang}/{word_id}" under the "Lemmatron" heading

# Feature:
# As a user
# When I visit "/"
# And I fill in a text box with "foxes"
# And I click "Validate Word"
# Then I should see a message that says "'foxes' is a valid word and its root form is 'fox'."

# As a user
# When I visit "/"
# And I fill in a text box with "foxez"
# And I click "Validate Word"
# Then I should see a message that says "'foxez' is not a valid word."