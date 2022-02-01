require 'rails_helper'

RSpec.describe "roasters/edit", type: :view do
  before(:each) do
    @roaster = assign(:roaster, Roaster.create!(
      user: nil,
      name: "MyString",
      description: "MyText",
      location: "MyString",
      lat: "9.99",
      lng: "9.99",
      website: "MyString",
      twitter: "MyString",
      instagram: "MyString",
      facebook: "MyString"
    ))
  end

  it "renders the edit roaster form" do
    render

    assert_select "form[action=?][method=?]", roaster_path(@roaster), "post" do

      assert_select "input[name=?]", "roaster[user_id]"

      assert_select "input[name=?]", "roaster[name]"

      assert_select "textarea[name=?]", "roaster[description]"

      assert_select "input[name=?]", "roaster[location]"

      assert_select "input[name=?]", "roaster[lat]"

      assert_select "input[name=?]", "roaster[lng]"

      assert_select "input[name=?]", "roaster[website]"

      assert_select "input[name=?]", "roaster[twitter]"

      assert_select "input[name=?]", "roaster[instagram]"

      assert_select "input[name=?]", "roaster[facebook]"
    end
  end
end
