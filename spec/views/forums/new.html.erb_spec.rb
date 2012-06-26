require 'spec_helper'

describe "forums/new" do
  before(:each) do
    assign(:forum, stub_model(Forum,
      :category_id => 1,
      :forum_title => "MyString",
      :description => "MyString"
    ).as_new_record)
  end

  it "renders new forum form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forums_path, :method => "post" do
      assert_select "input#forum_category_id", :name => "forum[category_id]"
      assert_select "input#forum_forum_title", :name => "forum[forum_title]"
      assert_select "input#forum_description", :name => "forum[description]"
    end
  end
end
