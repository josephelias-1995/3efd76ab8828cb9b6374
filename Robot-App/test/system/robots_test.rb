require "application_system_test_case"

class RobotsTest < ApplicationSystemTestCase
  setup do
    @robot = robots(:one)
  end

  test "visiting the index" do
    visit robots_url
    assert_selector "h1", text: "Robots"
  end

  test "creating a Robot" do
    visit robots_url
    click_on "New Robot"

    check "Is placed" if @robot.is_placed
    fill_in "Table cordinate", with: @robot.table_cordinate
    click_on "Create Robot"

    assert_text "Robot was successfully created"
    click_on "Back"
  end

  test "updating a Robot" do
    visit robots_url
    click_on "Edit", match: :first

    check "Is placed" if @robot.is_placed
    fill_in "Table cordinate", with: @robot.table_cordinate
    click_on "Update Robot"

    assert_text "Robot was successfully updated"
    click_on "Back"
  end

  test "destroying a Robot" do
    visit robots_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Robot was successfully destroyed"
  end
end
