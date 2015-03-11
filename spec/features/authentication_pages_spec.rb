require 'rails_helper'

describe "Authentication" do

  subject { page }

    describe "Sign in" do
      
    before { visit signin_path }
      it "Has a proper title" do

     expect(subject).to have_selector('h1', text: 'Sign in') 
    end
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it "Has a proper title" do
        expect(subject).to have_selector('h1', text: 'Sign in')
      end
      it "Has proper alert text" do
        expect(subject).to have_selector('div.alert.alert', text: 'Invalid')
      end  

      describe "after visiting another page" do
        before { click_link "Home" }
        
        it "Should not have and alert" do
          expect(subject).not_to have_selector('div.alert.alert')
        end
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end
      it "Should have a proper title" do
        expect(subject).to have_selector('h1', text: user.name)
      end
      it "Should have a link to the privacy page" do
        expect(subject).to have_link('Privacy',    href: privacy_path) 
      end
      it "Should have a link to the about path" do
        expect(subject).to have_link('About', href: about_path) 
      end
      it "Should have a link to the contact path" do
        expect(subject).to have_link('Contact', href: contact_path)
      end
      #it { should have_link('News', href: "http://news.railstutorial.org") }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it "Should have a link to the sign in page" do
          expect(subject).to have_link('Sign in')
        end
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(subject).to have_selector('h1', text: user.name)
          end

          describe "when signing in again" do
            before do
              #delete signout_path
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              expect(subject).to have_selector('h1', text: user.name) 
            end
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it "Should have a proper title" do
            expect(subject).to have_selector('h1', text: 'Sign in')
          end
        end

        # describe "submitting to the update action" do
          # before { put user_path(user) }
          # it "Should redirect to signin path" do
            # expect(response).to redirect_to(signin_path)
          # end
        # end

        describe "visiting user index" do
          before { visit users_path }
          it "Should should redirect to" do
            expect(subject).to have_selector('h1', text: 'Sign in')
          end 
        end

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it "Should have a title of Sign in" do
            expect(subject).to have_selector('h1', text: 'Sign in')
          end
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it "Should have a title of Sign in" do
            expect(subject).to have_selector('h1', text: 'Sign in')
          end
        end
      end

      #describe "in the Microposts controller" do

        # describe "submitting to the create action" do
          # before { post microposts_path }
          # it "Should redirect to signin_path" do
            # expect(subject).to have_selector('h1', text: 'Sign in')
          # end 
        # end

        # describe "submitting to the destroy action" do
          # before do
            # micropost = FactoryGirl.create(:micropost)
            # delete micropost_path(micropost)
          # end
          # it "Should redirect to signin_path" do
            # expect(subject).to have_selector('h1', text: 'Sign in')
          # end 
        # end
      end

      # describe "in the Relationships controller" do
        # describe "submitting to the create action" do
          # before { post relationships_path }
          # it "Should redirect to signin_path" do
            # expect(subject).to have_selector('h1', text: 'Sign in')
          # end
         # end
# 
        # describe "submitting to the destroy action" do
          # before { delete relationship_path(1) }
          # it "Should redirect to signin_path" do
            # expect(subject).to have_selector('h1', text: 'Sign in')
          # end          
        # end
      # end
    # end

    # describe "as wrong user" do
      # let(:user) { FactoryGirl.create(:user) }
      # let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      # before { sign_in user }
# 
      # describe "visiting Users#edit page" do
        # before { visit edit_user_path(wrong_user) }
        # it "Should have a proper full title" do
          # expect(subject).to have_selector('title', text: full_title(''))
        # end 
      # end
# 
      # describe "submitting a PUT request to the Users#update action" do
        # before { put user_path(wrong_user) }
        # it "Should redirect to root_path" do
          # expect(response).to redirect_to(root_path)
        # end 
      # end
    # end

    # describe "as non-admin user" do
      # let(:user) { FactoryGirl.create(:user) }
      # let(:non_admin) { FactoryGirl.create(:user) }
# 
      # before { sign_in non_admin }
# 
      # describe "submitting a DELETE request to the Users#destroy action" do
        # before { delete user_path(user) }
        # it "Should redirect to root_path" do
          # expect(subject).to have_selector('h1', text: 'Sign in')
        # end         
      # end
    # end
  end
end