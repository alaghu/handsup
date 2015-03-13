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
    
    #to retrieve the label from the first line
    def retrieve_label_from_first_line(string)
        
        #obtaining string prior to fullsource
        pre_fullsource = string.match('fullsource').pre_match
      
        #obtaining string post '# ', which is the beginning of the line
        post_initial_chars = pre_fullsource.match('# ').post_match
     
        #removing any unwanted spaces
        label = post_initial_chars.strip
        
        return label
    end
    
end
