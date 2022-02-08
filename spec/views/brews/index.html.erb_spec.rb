require 'rails_helper'

RSpec.describe 'brews/index', type: :view do
  before(:each) do
    assign(:brews, [
             Brew.create!(
               user: nil,
               coffee: nil,
               equipment: 'Equipment',
               method: 'Method',
               coffee_weight: 2,
               water_weight: 3,
               grinder: 'Grinder',
               grinder_setting: 'Grinder Setting',
               time: 4,
               notes: 'MyText',
               rating: 5
             ),
             Brew.create!(
               user: nil,
               coffee: nil,
               equipment: 'Equipment',
               method: 'Method',
               coffee_weight: 2,
               water_weight: 3,
               grinder: 'Grinder',
               grinder_setting: 'Grinder Setting',
               time: 4,
               notes: 'MyText',
               rating: 5
             )
           ])
  end

  it 'renders a list of brews' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Equipment'.to_s, count: 2
    assert_select 'tr>td', text: 'Method'.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: 3.to_s, count: 2
    assert_select 'tr>td', text: 'Grinder'.to_s, count: 2
    assert_select 'tr>td', text: 'Grinder Setting'.to_s, count: 2
    assert_select 'tr>td', text: 4.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 5.to_s, count: 2
  end
end
