require 'rails_helper'

RSpec.describe "roasters/show", type: :view do
  before(:each) do
    @roaster = assign(:roaster, Roaster.create!(
      user: nil,
      name: "Name",
      description: "MyText",
      location: "Location",
      lat: "9.99",
      lng: "9.99",
      website: "Website",
      twitter: "Twitter",
      instagram: "Instagram",
      facebook: "Facebook"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Website/)
    expect(rendered).to match(/Twitter/)
    expect(rendered).to match(/Instagram/)
    expect(rendered).to match(/Facebook/)
  end
end
