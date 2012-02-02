require 'spec_helper'

describe "accounts/index" do
  before(:each) do
    assign(:accounts, [
      stub_model(Account,
        :name => "Name",
        :role => "Role",
        :owner => nil
      ),
      stub_model(Account,
        :name => "Name",
        :role => "Role",
        :owner => nil
      )
    ])
  end

  it "renders a list of accounts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Role".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
