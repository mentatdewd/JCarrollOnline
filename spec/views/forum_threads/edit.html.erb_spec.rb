require 'spec_helper'

describe "forum_threads/edit" do
  before(:each) do
    @forum_thread = assign(:forum_thread, stub_model(ForumThread,
      :forum_thread_title => "MyString",
      :forum_thread_content => "MyText",
      :author_id => 1,
      :locked => false,
      :parent_id => 1
    ))
  end

  it "renders the edit forum_thread form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => forum_threads_path(@forum_thread), :method => "post" do
      assert_select "input#forum_thread_forum_thread_title", :name => "forum_thread[forum_thread_title]"
      assert_select "textarea#forum_thread_forum_thread_content", :name => "forum_thread[forum_thread_content]"
      assert_select "input#forum_thread_author_id", :name => "forum_thread[author_id]"
      assert_select "input#forum_thread_locked", :name => "forum_thread[locked]"
      assert_select "input#forum_thread_parent_id", :name => "forum_thread[parent_id]"
    end
  end
end
