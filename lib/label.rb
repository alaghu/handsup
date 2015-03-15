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
  
  # to spli
  def retrieve_date_from_label(label)
  
    "03-Jan-2015"
  end  
  
end
