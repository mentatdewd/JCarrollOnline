require 'spec_helper'

describe "forum_threads/show" do
  before(:each) do
    @forum_thread = assign(:forum_thread, stub_model(ForumThread,
      :forum_thread_title => "Forum Thread Title",
      :forum_thread_content => "MyText",
      :author_id => 1,
      :locked => false,
      :parent_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Forum Thread Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/false/)
    rendered.should match(/2/)
  end
end
