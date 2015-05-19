defmodule HashtagTest do
  use ExUnit.Case, async: true

  doctest Hashtag

  test "it extracts hashtags from text" do
    assert Hashtag.get_hashtags("#sorrynotsorry") == ["sorrynotsorry"]
  end

  test "it extracts hashtags when there are other words" do
    assert Hashtag.get_hashtags("Hello #world yeah") == ["world"]
  end

  test "it only extracts the word when there are multiple #s" do
    assert Hashtag.get_hashtags("#########live") == ["live"]
  end

  test "it extracts multiple hashtags" do
    assert Hashtag.get_hashtags("#Hello #world yeah") == ["Hello", "world"]
  end

  test "it does not extract #s alone" do
    assert Hashtag.get_hashtags("# # # #") == []
  end

  test "it does not extract hashtags in the middle of a word" do
    assert Hashtag.get_hashtags("hello#world") == []
  end

  test "it does not extract hashtags in the middle of a word extra" do
    assert Hashtag.get_hashtags("#hello#world") == []
  end

  test "it does not extract hashtags starting with numbers" do
    assert Hashtag.get_hashtags("#123hi") == []
  end

  test "it does not extract hashtags starting with special characters" do
    assert Hashtag.get_hashtags("#?what") == []
  end
end
