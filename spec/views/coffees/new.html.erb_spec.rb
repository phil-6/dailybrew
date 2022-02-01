require 'rails_helper'

RSpec.describe "coffees/new", type: :view do
  before(:each) do
    assign(:coffee, Coffee.new(
      roaster: nil,
      name: "MyString",
      country: "MyString",
      region: "MyString",
      town: "MyString",
      lat: "9.99",
      lng: "9.99",
      process: "MyString",
      altitude: 1,
      variety: "MyString",
      tasting_notes: "MyString",
      producer: "MyString",
      description: "MyText",
      url: "MyString"
    ))
  end

  it "renders new coffee form" do
    render

    assert_select "form[action=?][method=?]", coffees_path, "post" do

      assert_select "input[name=?]", "coffee[roaster_id]"

      assert_select "input[name=?]", "coffee[name]"

      assert_select "input[name=?]", "coffee[country]"

      assert_select "input[name=?]", "coffee[region]"

      assert_select "input[name=?]", "coffee[town]"

      assert_select "input[name=?]", "coffee[lat]"

      assert_select "input[name=?]", "coffee[lng]"

      assert_select "input[name=?]", "coffee[process]"

      assert_select "input[name=?]", "coffee[altitude]"

      assert_select "input[name=?]", "coffee[variety]"

      assert_select "input[name=?]", "coffee[tasting_notes]"

      assert_select "input[name=?]", "coffee[producer]"

      assert_select "textarea[name=?]", "coffee[description]"

      assert_select "input[name=?]", "coffee[url]"
    end
  end
end
