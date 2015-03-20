# A gem that makes Regular Expression as english statements
require 'verbal_expressions'

# The Label class - Attempting retrieve relavant information from a label
class Label
  # TODO: humanize_label_date

  DEFAULT_VALUE = 'Blank'
  # Currently having these attributes as read only.
  # also having date_time as a seperate variable to obtain segment 4 of a label
  attr_reader :name, :series, :version, :platform, :date_time, :date, :time
  attr_reader :validation_status
  def initialize(name)
    @name = name
    @series = DEFAULT_VALUE
    @version = DEFAULT_VALUE
    @platform = DEFAULT_VALUE
    @date_time = DEFAULT_VALUE
    @date = DEFAULT_VALUE
    @time = DEFAULT_VALUE
    @validation_status = DEFAULT_VALUE
  end

  # Validating if there are 3 underscores
  def validate_label
    # defining a pattern
    pattern_for_underscores = VerEx.new do
      find '_'
    end

    # string.scan(pattern_to_scan)
    if @name.scan(pattern_for_underscores).count == 3

      then @validation_status = 'success'

    else @validation_status = 'failed validation'

    end
  end

  # TODO: rename method
  def retrieve_segments_from_label
    # defining the pattern through englished regular expression
    pattern_for_segments = VerEx.new do
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
      begin_capture 'date_time'
      anything_but '_'
      end_capture
    end

    @name.match(pattern_for_segments) do |match_values|
      @series = match_values['series']
      @version =  match_values['version']
      @platform = match_values['platforms']
      @date_time = match_values['date_time']
    end

    # remember you need to call retrieve segments from label
    # TODO: need to find how to call retrieve segments from label within this
    def retrieve_date_time
      # defining the pattern through englished regular expression
      # even though it is only a .
      pattern_for_dot = VerEx.new do
        find '.'
      end

      @date = @date_time.match(pattern_for_dot).pre_match
      @time = @date_time.match(pattern_for_dot).post_match
    end
  end
end

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
#  Date_Parsed
#  LabelName (The first Line)

# To retrieve the label from the first line
# The first_line will be some thing like
# 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file'
# Would return => 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550'
# TODO: Move this method to a differen class
#  def retrieve_label_from_first_line(first_line)
#
# obtaining first_line prior to fullsource
#   pre_fullsource = first_line.match('fullsource').pre_match

# obtaining first_line post '# ', which is the beginning of the line
#   post_initial_chars = pre_fullsource.match('# ').post_match

#   # removing any unwanted spaces
#   post_initial_chars.strip
#  end
