require 'label'

# TODO: - need to refactor - single object creation
describe Label, '#label' do
  it 'should come back with a label' do
    label = Label.new
    # TODO: variabilize the input text, preferebally from a file
    output = label.retrieve_label_from_first_line('# FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550 fullsource file, generated Sat Jan  3 16:03:00 2015 by aime1')
    expect(output).to eq('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
  end
  it 'should come back with 03-Jan-2015' do
    label = Label.new
    date_from_label = label.retrieve_date_from_label('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
    expect(date_from_label).to eq('150103.1550')
  end
  it 'should check for 3 underscores as a prereq for a lable' do
    label = Label.new
    number_of_underscore = label.validate_label_pattern('FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550')
  end
end
