require 'rails_helper'
require 'webmock/rspec'

RSpec.describe StoreUsersJob, type: :job do
  before do
    stub_request(:get, "https://randomuser.me/api/?results=20")
      .to_return(status: 200, body: response_body, headers: {})

    allow($redis).to receive(:set)
  end

  let(:response_body) do
    {
      results: [
        {
          gender: "male",
          name: { title: "Mr", first: "John", last: "Doe" },
          login: { uuid: "123" },
          email: "john.doe@example.com",
          dob: { age: 30 }
        },
        {
          gender: "female",
          name: { title: "Ms", first: "Jane", last: "Doe" },
          login: { uuid: "456" },
          email: "jane.doe@example.com",
          dob: { age: 25 }
        }
      ]
    }.to_json
  end

  it "fetches users and stores them in the database" do
    expect {
      StoreUsersJob.new.perform
    }.to change { User.count }.by(2)

    user1 = User.find_by(uuid: "123")
    expect(user1).to have_attributes(
      gender: "male",
      title: "Mr",
      first_name: "John",
      last_name: "Doe",
      email: "john.doe@example.com",
      age: 30
    )

    user2 = User.find_by(uuid: "456")
    expect(user2).to have_attributes(
      gender: "female",
      title: "Ms",
      first_name: "Jane",
      last_name: "Doe",
      email: "jane.doe@example.com",
      age: 25
    )
  end

  it "sets the correct male and female counts in Redis" do
    StoreUsersJob.new.perform

    expect($redis).to have_received(:set).with('male_count', 1)
    expect($redis).to have_received(:set).with('female_count', 1)
  end
end
