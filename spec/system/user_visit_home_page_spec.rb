require 'rails_helper'

describe 'User visit home page' do
  it 'from URL' do
    visit root_path

    expect(page).to have_content 'Nobe Bank'
    expect(page).to have_current_path root_path
  end
end
