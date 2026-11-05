# frozen_string_literal: true

module SearchHelper
  def search_for(keyword)
    fill_in 'q[keyword]', with: keyword
    find('input[name="q[keyword]"]').send_keys(:return)
  end

  def expect_total_count(count)
    expect(page).to have_text(/検索結果\s*#{count}\s*件の施設/)
  end

  def expect_only_visible_facilities(*facilities)
    all_facilities = [facility_tokyo, facility_yokohama, facility_chiba]

    all_facilities.each do |facility|
      if facilities.include?(facility)
        expect(page).to have_content(facility.name)
      else
        expect(page).not_to have_content(facility.name)
      end
    end
  end
end
