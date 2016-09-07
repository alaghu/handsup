# A gem that makes Regular Expression as english statements
require 'verbal_expressions'

# The Label class -Retrieve relevant information about a label
class Label
  # Instance Variables and its usage
  # FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550
  attr_reader :name
  # FAINTEG
  attr_reader :series
  # 11.1.9.2.0
  attr_reader :version
  # PLATFORMS
  attr_reader :platform
  # 150103.1550
  attr_reader :date_time
  # 150103
  attr_reader :date
  # 1550
  attr_reader :time
  # Success! or Failed.
  attr_reader :validation_status
  # Could not find three underscores
  attr_reader :message

  # Setting default value to 'Blank'
  DEFAULT_VALUE = 'Blank'.freeze

  # Initialize method that sets the default value
  # and invokes the subsequent methods.
  def initialize(name)
    @name = name
    # Setting all instance variables to default
    @series = DEFAULT_VALUE
    @version = DEFAULT_VALUE
    @platform = DEFAULT_VALUE
    @date_time = DEFAULT_VALUE
    @date = DEFAULT_VALUE
    @time = DEFAULT_VALUE
    @validation_status = DEFAULT_VALUE
    # Invoking the different methods
    validate_label
    retrieve_segments_from_label if @validation_status == 'Success!'
  end

  # Validating different patterns
  # Returns validation_status as success
  def validate_label
    # inoke the validation methods
    validate_three_underscores
    validate_max_two_dots_in_the_end
    is_it_a_scratch
  end

  # A label will have only three underscores
  def validate_three_underscores
    # string.scan(pattern_to_scan)
    if @name.scan('_').count == 3
      @validation_status = 'Success!'
      @message = 'Found three underscores.'
    else
      @validation_status = 'Failed.'
      @message = 'Could not find exactly three underscores.'
    end
  end

  # A label will have maximum of two dots from date
  # Ex 1 : 150103.1550
  # Ex 2 : 150103.1550.s
  def validate_max_two_dots_in_the_end
    # search in the last 7 characters there is only two dots
    length_of_label = @name.length
    last_seven_chars = @name[(length_of_label - 7)..length_of_label]
    if last_seven_chars.scan('.').count > 2
      @validation_status = 'Failed.'
      @message = 'Found more than two dots in the final part of the label.'
    end
  end

  # TODO: rename method
  def retrieve_segments_from_label
    # defining the pattern through englished regular expression
    # This is called capturing
    # https://github.com/ryan-endacott/verbal_expressions#regex-capturing
    pattern_for_segments = VerEx.new do
      start_of_line
      begin_capture 'series' # Named Capture
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

    # Passing the named captures to retrieve the values
    @name.match(pattern_for_segments) do |match_values|
      @series = match_values['series']
      @version =  match_values['version']
      @platform = match_values['platforms']
      @date_time = match_values['date_time']
    end
  end

  # remember you need to call retrieve segments from label
  # TODO: need to find how to call retrieve segments from label within this
  def retrieve_date_time
    # before we retrieve date and time, we need obtain date_time segment
    # self.retrieve_segments_from_label

    # defining the pattern through englished regular expression
    # even though it is only a .
    # pattern_for_dot = VerEx.new do
    #   find '.'
    # end

    @date = @date_time.match(pattern_for_dot).pre_match
    @time = @date_time.match(pattern_for_dot).post_match
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
# TODO: Move this method to a differen clas
#  def retrieve_label_from_first_line(first_line)
#
# obtaining first_line prior to fullsource
#   pre_fullsource = first_line.match('fullsource').pre_match

# obtaining first_line post '# ', which is the beginning of the line
#   post_initial_chars = pre_fullsource.match('# ').post_match

#   # removing any unwanted spaces
#   post_initial_chars.strip
#  end
