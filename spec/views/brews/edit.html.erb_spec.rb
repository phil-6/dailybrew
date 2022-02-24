require 'rails_helper'

RSpec.describe 'brews/edit', type: :view do
  before(:each) do
    @brew = assign(:brew, Brew.create!(
                            user: nil,
                            coffee: nil,
                            equipment: 'MyString',
                            method: 'MyString',
                            coffee_weight: 1,
                            water_weight: 1,
                            grinder: 'MyString',
                            grinder_setting: 'MyString',
                            time: 1,
                            notes: 'MyText',
                            rating: 1
                          ))
  end

  it 'renders the edit brew form' do
    render

    assert_select 'form[action=?][method=?]', brew_path(@brew), 'post' do
      assert_select 'input[name=?]', 'brew[user_id]'

      assert_select 'input[name=?]', 'brew[coffee_id]'

      assert_select 'input[name=?]', 'brew[equipment]'

      assert_select 'input[name=?]', 'brew[method]'

      assert_select 'input[name=?]', 'brew[coffee_weight]'

      assert_select 'input[name=?]', 'brew[water_weight]'

      assert_select 'input[name=?]', 'brew[grinder]'

      assert_select 'input[name=?]', 'brew[grinder_setting]'

      assert_select 'input[name=?]', 'brew[time]'

      assert_select 'textarea[name=?]', 'brew[notes]'

      assert_select 'input[name=?]', 'brew[rating]'
    end
  end
end
