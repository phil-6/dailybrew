require 'rails_helper'

RSpec.describe "coffees/show", type: :view do
  before(:each) do
    @coffee = assign(:coffee, Coffee.create!(
      roaster: nil,
      name: "Name",
      country: "Country",
      region: "Region",
      town: "Town",
      lat: "9.99",
      lng: "9.99",
      process: "Process",
      altitude: 2,
      variety: "Variety",
      tasting_notes: "Tasting Notes",
      producer: "Producer",
      description: "MyText",
      url: "Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Region/)
    expect(rendered).to match(/Town/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Process/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Variety/)
    expect(rendered).to match(/Tasting Notes/)
    expect(rendered).to match(/Producer/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Url/)
  end
end
