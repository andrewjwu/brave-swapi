module PagesHelper
  def swapi_data_parser(input)
    if endpoint = SWAPI_URL_REGEX.match(input)
      "<a data-remote='true' href='/?endpoint=#{endpoint[1]}'>#{input}</a>"
    else
      input
    end
  end
end
