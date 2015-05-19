defmodule Hashtag do
  @moduledoc ~S"""
  A module to hold methods for extracting hashtags from text
  """

  @type t :: binary

  @doc ~S"""
  Takes some text and returns a list of tags from the
  text that were tagged with hashes

  ## Examples:

      iex> Hashtag.get_hashtags("#hello #world yeah")
      ["hello", "world"]

      iex> Hashtag.get_hashtags("#####zomg")
      ["zomg"]

      iex> Hashtag.get_hashtags("nothing here")
      []
  """

  @spec get_hashtags(t) :: [t]

  def get_hashtags(text) do
    text
    |> String.split
    |> Enum.map(&extract_tag/1)
    |> Enum.reject(&is_nil/1)
  end

  defp extract_tag("#"), do: nil
  defp extract_tag("#" <> tag) do
    tag
    |> clean_tag
    |> verify_tag
  end
  defp extract_tag(_), do: nil

  defp clean_tag("#" <> tag), do: clean_tag(tag)
  defp clean_tag(tag) do
    tag
    |> String.split("#")
    |> case do
      [tag] -> tag
      _     -> ""
    end
  end

  defp verify_tag(tag) do
    tag
    |> String.match?(~r/^[a-z]/i)
    |> case do
      true -> tag
      _    -> nil
    end
  end
end

