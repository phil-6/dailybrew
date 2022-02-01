require 'rails_helper'

RSpec.describe "brews/show", type: :view do
  before(:each) do
    @brew = assign(:brew, Brew.create!(
      user: nil,
      coffee: nil,
      equipment: "Equipment",
      method: "Method",
      coffee_weight: 2,
      water_weight: 3,
      grinder: "Grinder",
      grinder_setting: "Grinder Setting",
      time: 4,
      notes: "MyText",
      rating: 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Equipment/)
    expect(rendered).to match(/Method/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Grinder/)
    expect(rendered).to match(/Grinder Setting/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/5/)
  end
end
