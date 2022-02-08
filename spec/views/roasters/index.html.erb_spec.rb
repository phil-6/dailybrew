require 'rails_helper'

RSpec.describe 'roasters/index', type: :view do
  before(:each) do
    assign(:roasters, [
             Roaster.create!(
               user: nil,
               name: 'Name',
               description: 'MyText',
               location: 'Location',
               lat: '9.99',
               lng: '9.99',
               website: 'Website',
               twitter: 'Twitter',
               instagram: 'Instagram',
               facebook: 'Facebook'
             ),
             Roaster.create!(
               user: nil,
               name: 'Name',
               description: 'MyText',
               location: 'Location',
               lat: '9.99',
               lng: '9.99',
               website: 'Website',
               twitter: 'Twitter',
               instagram: 'Instagram',
               facebook: 'Facebook'
             )
           ])
  end

  it 'renders a list of roasters' do
    render
    assert_select 'tr>td', text: nil.to_s, count: 2
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: 'Location'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: 'Website'.to_s, count: 2
    assert_select 'tr>td', text: 'Twitter'.to_s, count: 2
    assert_select 'tr>td', text: 'Instagram'.to_s, count: 2
    assert_select 'tr>td', text: 'Facebook'.to_s, count: 2
  end
end
