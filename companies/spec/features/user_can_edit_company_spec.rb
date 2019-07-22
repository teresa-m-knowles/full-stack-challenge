require 'rails_helper'

RSpec.feature "A user can edit a company", type: :feature do
  describe "As a user" do
    describe "When I visit a company's show page" do
      describe "and click on the Edit button" do
        before :each do
          @company = build(:company)
          @company.save
          visit company_path(@company)
          click_button "Edit"
        end
        it "my current path is now the edit path" do
          expect(current_path).to eq(edit_company_path(@company))
        end
        it "takes me to a form to edit the company" do
          expect(page).to have_field("company[name]")
          expect(page).to have_field("City")
          expect(page).to have_field("State")
          expect(page).to have_field("Description")
          expect(page).to have_field("date-picker")
        end
        it "allows me to edit fields" do
          old_name = @company.name
          fill_in "company_name", with: "New Name"
          click_button "Save"
          expect(current_path).to eq(company_path(@company))
          expect(page).to have_content("New Name")
          expect(page).to_not have_content(old_name)
          expect(@company.name).to eq("New Name")
        end
      end
    end
  end
end