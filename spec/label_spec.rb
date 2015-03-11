require 'label'

describe Label, "#label" do
    it "should come back with a label" do
        
    label = Label.new
    
    output = label.retrieve_label_from_first_line("# FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file, generated Sat Jan  3 16:03:00 2015 by aime1")
    
    expect(output).to eq("FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550")
    
    end
end