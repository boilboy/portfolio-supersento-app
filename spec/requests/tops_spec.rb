require 'rails_helper'

RSpec.describe "Tops", type: :request do
  describe "GET /home" do
    it "ホーム画面の表示に成功すること" do
      get root_path
      expect(response).to have_http_status(:ok)
    end
  end
end
