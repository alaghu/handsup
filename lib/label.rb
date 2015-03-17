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
  # This class will attempt to decipher the label
  # Should have the following methods
  # retrieve_segments_from_label
  # humanize_label_date
  # validate_label
  # 
  # To retrieve the label from the first line
  # The first_line will be some thing like
  # 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file'
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
    @date = nil
    get_series = VerEx.new do
      start_of_line
      begin_capture 'series'
      anything_but '_'
      end_capture
      # First Underscore
      find '_'
      begin_capture 'version'
      anything_but '_'
      end_capture
      # Second Underscore
      find '_'
      begin_capture 'platforms'
      anything_but '_'
      end_capture
      # Third Underscore
      find '_'
      begin_capture 'date'
      anything_but '_'
      end_capture
    end

    label.match(get_series) do |match_values|
      puts match_values['series']
      puts match_values['version']
      puts match_values['platforms']
      puts match_values['date']
      @date = match_values['date']
    end

    @date
  end
  def validate_label_pattern(label)
    # First Check - 3 underscores
    count_underscores = VerEx.new do
      start_of_line
    end
  end
end
