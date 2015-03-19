require 'label'

# TODO: - need to refactor - single object creation
describe Label do
  # This is for testing initialization
  it 'has to have attributes set to Blank' do
    a_new_label = Label.new

    expect(a_new_label.series).to eq('Blank')
    expect(a_new_label.version).to eq('Blank')
    expect(a_new_label.platform).to eq('Blank')
    expect(a_new_label.date).to eq('Blank')
    expect(a_new_label.validation_status).to eq('Blank')
  end

  it 'should come back with valid segments' do
    label_segments = Label.new
  
    label_segments.retrieve_segments_from_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')

    expect(label_segments.series).to eq('FAINTEG')
    expect(label_segments.version).to eq('11.1.9.2.0')
    expect(label_segments.platform).to eq('PLATFORMS')
    expect(label_segments.date).to eq('150103.1550')
  end

  it 'should have only 3 underscores' do
    validating_label = Label.new

    validating_label.validate_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')

    expect(validating_label.validation_status).to eq('success')
  end

  it 'should not have more than 3 underscores' do
    validating_label = Label.new

    validating_label.validate_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550_')

    expect(validating_label.validation_status).to eq('failed validation')
  end

  # TODO: This method should be moved to a different class altogether
  # it 'should come back with a label' do
  #   label = Label.new
  #   # TODO: variabilize the input text, preferebally from a file

  #   output = label.retrieve_label_from_first_line('# FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file, generated Sat Jan  3 16:03:00 2015 by aime1')

  #   expect(output).to eq('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
  # end
end
