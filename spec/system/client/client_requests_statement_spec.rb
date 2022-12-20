require 'rails_helper'

describe 'client requests statement' do
  it 'filtered by initial and end date' do
    client = create :client
    stt1 = create(:account_statement, name: 'Déposito', move_date: 3.day.ago, moved_value: 3300, client:)
    stt2 = create(:account_statement, name: 'Saque', move_date: 2.day.ago, moved_value: -100, client:)
    stt3 = create(:account_statement, name: 'Saque', move_date: 1.day.ago, moved_value: -500, client:)
    stt4 = create(:account_statement, name: 'Déposito', move_date: Date.today, moved_value: 1000, client:)

    login_as client
    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_content "Déposito | R$ 3.300,00 | id: #{stt1.id} | Data: #{stt1.move_date}"
    expect(page).to have_content "Saque | R$ -100,00 | id: #{stt2.id} | Data: #{stt2.move_date}"
    expect(page).to have_content "Saque | R$ -500,00 | id: #{stt3.id} | Data: #{stt3.move_date}"
    expect(page).not_to have_content "Déposito | R$ 1.000,00 | id: #{stt4.id} | Data: #{stt4.move_date}"
  end

  it 'and theres no results' do
    client = create :client

    login_as client
    visit root_path
    fill_in 'Data Inicial', with: 3.day.ago
    fill_in 'Data Final', with: 1.day.ago
    click_on 'Solicitar extrato'

    expect(page).to have_content 'Nenhuma movimentação encontrada'
  end
end
