require 'rails_helper'

RSpec.describe "roasters/new", type: :view do
  before(:each) do
    assign(:roaster, Roaster.new(
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

  it "renders new roaster form" do
    render

    assert_select "form[action=?][method=?]", roasters_path, "post" do

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
