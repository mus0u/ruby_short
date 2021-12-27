class ShortUrlsControllerTest < ActionDispatch::IntegrationTest

  test "create returns 201 (created) with a short_code when given a long_url" do
    post short_urls_path, params: { long_url: "http://crouton.net" }, as: :json

    assert_response :created

    resp = @response.parsed_body

    assert resp["id"]
    assert resp["short_code"].length == 8
    assert resp["long_url"] == "http://crouton.net"
    assert resp["created_at"]
    assert resp["updated_at"]
  end

  test "create returns 422 (unprocessable entity) when given invalid params" do
    # TODO: implement this test!
    skip "not yet implemented"
  end

  test "show redirects the user to the long_url given by a valid short_code" do
    example = short_urls(:example)
    get short_url_path(example.short_code)

    assert_response :found
    assert @response.location == example.long_url
  end

  test "show returns 404 when no short_url exists for the given short_code" do
    get short_url_path("invalid")

    assert_response :not_found
  end
end
