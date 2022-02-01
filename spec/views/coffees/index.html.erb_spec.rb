require 'rails_helper'

RSpec.describe "coffees/index", type: :view do
  before(:each) do
    assign(:coffees, [
      Coffee.create!(
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
      ),
      Coffee.create!(
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
      )
    ])
  end

  it "renders a list of coffees" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Country".to_s, count: 2
    assert_select "tr>td", text: "Region".to_s, count: 2
    assert_select "tr>td", text: "Town".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Process".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "Variety".to_s, count: 2
    assert_select "tr>td", text: "Tasting Notes".to_s, count: 2
    assert_select "tr>td", text: "Producer".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "Url".to_s, count: 2
  end
end
