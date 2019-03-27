function clear_special_symbols() # remove or escape special characters from input to avoid JSON format parsing failures
{
  gsub(/\\/,"\\\\")
  gsub(/\r/,"")
  gsub(/\b/,"")
  gsub(/\"/,"\\\"")
  gsub(/\t/,"\\t")
  gsub(/[\x00-\x1F\x7F]/,"")
}
