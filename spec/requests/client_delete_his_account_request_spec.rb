require 'rails_helper'

describe 'client delete his account' do
  it 'from the request' do
    client = create :client, name: 'Kilder Costa', password: 'password123', email: 'costa.kilder@gmail.com'
    login_as client

    delete client_registration_path

    expect(client.persisted?).to eq true
  end
end
