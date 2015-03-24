require 'label'

describe Label do
  # will setup a sample label
  describe 'Positive cases' do
    # This sets up the data for all it blocks withing 'Positive cases'
    # A note about let method ----------------
    # The let method allows us to create the pre-req data by using the method
    # name. Plus, the variables are accessible in the subsequent blocks. Next,
    # the object is memoized - cached. Refer to SO#5359979
    #
    # creating sample label
    # this will cause rubocop violation! That is ok. Ignore.
    let(:a_sample_label) do
      a_sample_label = 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550'
    end

    # creating a label object with the sample label as input
    let(:a_new_label) do
      a_new_label = Label.new(a_sample_label)
    end

    # This is for testing initialization
    it 'has to have attributes set to Blank' do
      # checking one attribute after the other
      expect(a_new_label.name).to eq(a_sample_label)
      expect(a_new_label.series).to eq('Blank')
      expect(a_new_label.version).to eq('Blank')
      expect(a_new_label.platform).to eq('Blank')
      expect(a_new_label.date_time).to eq('Blank')
      expect(a_new_label.date).to eq('Blank')
      expect(a_new_label.time).to eq('Blank')
      expect(a_new_label.validation_status).to eq('Blank')
    end

    it 'should have only 3 underscores' do
      # invoking the validate label
      a_new_label.validate_label

      expect(a_new_label.validation_status).to eq('success')
    end

    it 'should come back with valid segments' do
      # invoking the retrieve_segments method
      a_new_label.retrieve_segments_from_label

      expect(a_new_label.series).to eq('FAINTEG')
      expect(a_new_label.version).to eq('11.1.9.2.0')
      expect(a_new_label.platform).to eq('PLATFORMS')
      expect(a_new_label.date_time).to eq('150103.1550')
    end

    it 'should come back with a date and time' do
      # invoking the retrieve_date_time
      a_new_label.retrieve_date_time

      expect(a_new_label.date).to eq('150103')
      expect(a_new_label.time).to eq('1550')
    end
  end

  describe 'Negative cases' do
    # This sets up the data for all it blocks withing 'Positive cases'
    let(:a_sample_negative_label) do
      a_sample_negative_label = 'FAINTEG_11.1.9.2.0_PLATFORMS_150103.1550_'
    end

    let(:a_new_label) do
      a_new_label = Label.new(a_sample_negative_label)
    end

    it 'should not have more than 3 underscores' do
      # invoking the validate label
      a_new_label.validate_label
      failed_message = 'validation failed - I did not get 3 underscores'

      expect(a_new_label.validation_status).to eq(failed_message)
    end
  end
end
