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
    retrieve_date_time if @validation_status == 'Success!'
  end

  # Validating different patterns
  # Returns validation_status as success
  def validate_label
    # inoke the validation methods
    validate_three_underscores
    # validate_max_two_dots_in_the_end
    # is_it_a_scratch
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
    @date = @date_time.split('.').first
    @time = @date_time.split('.').last
  end
end
