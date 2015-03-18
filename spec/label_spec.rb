require 'label'

# TODO: - need to refactor - single object creation
describe Label, '#label' do
  # TODO: This method should be moved to a different class altogether
  it 'should come back with a label' do
    label = Label.new
    # TODO: variabilize the input text, preferebally from a file

    output = label.retrieve_label_from_first_line('# FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file, generated Sat Jan  3 16:03:00 2015 by aime1')

    expect(output).to eq('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
  end

  # This is for testing initialization
  it 'The  Series,version, platform, and date should set to Blank' do
    a_new_label = Label.new

    expect(a_new_label.series).to eq('Blank')
    expect(a_new_label.version).to eq('Blank')
    expect(a_new_label.platform).to eq('Blank')
    expect(a_new_label.date).to eq('Blank')
    expect(a_new_label.validation_status).to eq('Blank')
  end

  it 'should come back with 03-Jan-2015' do
    label = Label.new
    date_from_label = label.retrieve_date_from_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
    expect(date_from_label).to eq('150103.1550')
  end

  it 'should validate only 3 underscores in a label' do
    validating_label = Label.new

    validating_label.validate_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
    
    expect(validating_label.validation_status).to eq('success')
    
  end
  
  it 'should fail in validate if more than 3 underscores' do
    validating_label = Label.new

    validating_label.validate_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550_')
    
    expect(validating_label.validation_status).to eq('failed validation')
  end
  
end
