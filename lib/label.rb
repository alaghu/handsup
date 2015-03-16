require 'verbal_expressions'
# This script will attempt to open a text file and parse its contents
# The script should identify different types of
# 10 Lines - a. Remarks or comments , b. Label details , and c. Other

# Depending on the line type, do the following
# 10a. Line Type = Comments
#      ignore. Do not parse

# 10b. Line Type = Label details.
#       Parse and get the following
#       Product_Schema
#       Label
#       Other Details
#       Label_Humanized
#       Date_Parsed
#       Product_Type

# 10c. Line Type = Others
#      marke as other and store. Do not parse.

# Model it as the following
# A. The whole file/Label = Label
# B. Each line = Lines

# Validations on Label
# If First line of the label does not contain a formed label, return error.
#
# Attributes on Label
# Date_Parsed
# LabelName (The first Line)
#

#
class Label
  # to retrieve the label from the first line
  # => The first_line will be some thing like
  # =>'# FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file'
  # Would return => 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550'
  def retrieve_label_from_first_line(first_line)
    # obtaining first_line prior to fullsource
    pre_fullsource = first_line.match('fullsource').pre_match

    # obtaining first_line post '# ', which is the beginning of the line
    post_initial_chars = pre_fullsource.match('# ').post_match

    # removing any unwanted spaces
    post_initial_chars.strip
  end

  # to split label up
  def retrieve_date_from_label(label)
    # Logic 1
    # Match the last dot
    # obtain the 6 characters to the left
    # FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550
    get_series = VerEx.new do
      start_of_line
      begin_capture 'series'
      anything_but '_'
      end_capture
      #
      find '_'
      # another begin
      begin_capture 'version'
      anything_but '_'
      end_capture
      #
      find '_'
      begin_capture 'platforms'
      anything_but '_'
      end_capture
      # another begin
      begin_capture 'date'
      anything_but '_'
      anything_but '\.'
      end_capture
    end

    label.match(get_series) do |match_values|
      puts match_values['series']
      puts match_values['version']
      puts match_values['platforms']
      puts match_values['date']
    end

    # Logic 2
    # Match the last underscore (_)
    # obtain the 6 characters till the dot (.)
    # convert to date type
    # Return the obtained date in the following format
    '03-Jan-2015'
  end
end
