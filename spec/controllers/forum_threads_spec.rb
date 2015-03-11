require 'rails_helper'

RSpec.describe ForumThreadsController, :type => :controller do

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }
  before { sign_in user, no_capybara: true }

# This should return the minimal set of attributes required to create a valid
# ForumThread. As you add validations to ForumThread, be sure to
# update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ForumThreadsController. Be sure to keep this updated too.
  def valid_session
    { }
  end

  describe "GET #index" do
    it "returns http success" do
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread, forum_id: forum.id)
      get :index, { :id => forum.id }, valid_session
      expect(assigns(:forum_threads)).to eq([forum_thread])
    end
  end

  describe "GET show" do
    it "assigns the requested forum_thread as @forum_thread" do
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread, forum_id: forum.id)
      get :show, {:id => forum.id}, valid_session
      expect(assigns(:forum_thread)).to eq(forum_thread)
    end
  end

  describe "GET new" do
    it "assigns a new forum_thread as @forum_thread" do
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread, forum_id: forum.id)
      parent_forum_thread = FactoryGirl.create(:forum_thread, forum_id: forum.id, parent_id: forum_thread.id)
      get :new, { :forum_id => forum.id, :parent_id => parent_forum_thread.id }, valid_session
      expect(assigns(:forum_thread)).to be_a_new(ForumThread)
    end
  end

  describe "GET edit" do
    it "assigns the requested forum_thread as @forum_thread" do
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread)
      get :edit, {:id => forum_thread.id}, valid_session
      expect(assigns(:forum_thread)).to eq(forum_thread)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ForumThread" do
        forum = FactoryGirl.create(:forum)
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread, :forum_id => forum.id)
        expect {
          post :create, {:forum_thread => forum_thread_attributes}, valid_session
        }.to change(ForumThread, :count).by(1)
      end

      it "assigns a newly created forum_thread as @forum_thread" do
        forum = FactoryGirl.create(:forum)
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread, :forum_id => forum.id)
        post :create, {:forum_thread => forum_thread_attributes}, valid_session
        expect(assigns(:forum_thread)).to be_a(ForumThread)
        expect(assigns(:forum_thread)).to be_persisted
      end

      it "redirects to the created forum_thread" do
        forum = FactoryGirl.create(:forum)
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread, :forum_id => forum.id)
        post :create, {:forum_thread => forum_thread_attributes}, valid_session
        expect(subject).to redirect_to(:id => ForumThread.last.id, :parent_id => ForumThread.last.id)
        #:id => @forum_thread.root.id, :parent_id => @forum_thread.root.id
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved forum_thread as @forum_thread" do
      # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ForumThread).to receive(:save).and_return(false)
        forum = FactoryGirl.create(:forum)
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread, :forum_id => forum.id)
        post :create, {:forum_thread => forum_thread_attributes}, valid_session
        expect(assigns(:forum_thread)).to be_a_new(ForumThread)
      end

      it "re-renders the 'new' template" do
      # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ForumThread).to receive(:save).and_return(false)
        forum = FactoryGirl.create(:forum)
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread, :forum_id => forum.id)
        post :create, {:forum_thread => forum_thread_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested forum_thread" do
        #forum_thread = ForumThread.create! valid_attributes
        
        forum = FactoryGirl.create(:forum)
        print 'Created forum: '
        puts forum.id
        forum_thread = FactoryGirl.create(:forum_thread, :forum_id => forum.id)
        print 'Created forum_thread: '
        print forum_thread.id
        print ' in forum: '
        puts forum.id
        forum_thread_attributes = FactoryGirl.attributes_for(:forum_thread)
        print 'forum_thread_attributes: '
        puts forum_thread_attributes
        
        # Assuming there are no other forum_threads in the database, this
        # specifies that the ForumThread created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        allow_any_instance_of(ForumThread).to receive(:update).with(:forum_thread_content => "Test forum thread")
        put :update, :id => forum_thread.to_param, :forum_thread_content => "Test forum thread"
        #expect(assigns(:forum_thread)).to eq(forum_thread)
      end

      it "assigns the requested forum_thread as @forum_thread" do
        # forum_thread = ForumThread.create! valid_attributes
        # put :update, {:thread_id => forum_thread.to_param}, valid_session
        # expect(assigns(:forum_thread)).to eq(forum_thread)
        pending "fix the forum_threads_controller PUT update with valid params assigns the requested forum_thread as @forum_thread, it's broken"
      end

      it "redirects to the forum_thread" do
        # forum_thread = ForumThread.create! valid_attributes
        # put :update, {:thread_id => forum_thread.to_param, :forum_thread => valid_attributes}, valid_session
        # expect(response).to redirect_to(forum_thread)
         pending "fix the forum_threads_controller PUT update with valid params redirects to the forum_thread, it's broken"
       
      end
    end

    describe "with invalid params" do
      it "assigns the forum_thread as @forum_thread" do
        #forum_thread = ForumThread.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ForumThread).to receive(:save).and_return(false)
        forum = FactoryGirl.create(:forum)
        forum_thread = FactoryGirl.create(:forum_thread, :forum_id => forum.id)
        put :update, {:thread_id => forum_thread.to_param, :forum_thread => {}}, valid_session
        expect(assigns(:forum_thread)).to eq(forum_thread)
      end

      it "re-renders the 'edit' template" do
        #forum_thread = ForumThread.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(ForumThread).to receive(:save).and_return(false)
        forum = FactoryGirl.create(:forum)
        forum_thread = FactoryGirl.create(:forum_thread, :forum_id => forum.id)
        put :update, {:thread_id => forum_thread.to_param, :forum_thread => {}}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested forum_thread" do
      #forum_thread = ForumThread.create! valid_attributes
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread, :forum_id => forum.id)
      expect {
        delete :destroy, {:thread_id => forum_thread.to_param}, valid_session
      }.to change(ForumThread, :count).by(-1)
    end

    it "redirects to the forum_threads list" do
      #forum_thread = ForumThread.create! valid_attributes
      forum = FactoryGirl.create(:forum)
      forum_thread = FactoryGirl.create(:forum_thread, :forum_id => forum.id)
      delete :destroy, {:thread_id => forum_thread.to_param}, valid_session
      expect(response).to redirect_to(forum_threads_url)
    end
  end
end
