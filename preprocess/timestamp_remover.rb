# The steps to prepare the training data are as follows:
#   1) preprocess/timestamp_remover.rb
#     1a) takes from data/original_transcripts/<interview>.txt
#     1b) saves to data/cleaned_transcripts/cleaned<interview>.txt
#   2) preprocess/transcript_processor.rb
#     2a) takes from data/cleaned_transcripts/cleaned<interview>.txt
#     2b) saves to data/processed_transcripts/cleaned<interview>.json
#   3) preprocess/NLPpreprocessor.rb
#     3a) takes from data/processed_transcripts/cleaned<interview>.json
#     3b) saves to data/nlp_preprocessed_transcripts/stemmed<brennan_transcript>.json
#   4) preprocess/vocab_generator.rb
#     4a) takes from data/nlp_preprocessed_transcripts/stemmed<brennan_transcript>.json
#     4b) saves to:
#       4bi   data/vocabulary/vocabulary.json', 
#       4bii  data/vocabulary/word_to_index.json
#       4biii data/vocabulary/index_to_word.json
#   5) preprocess/encoder.rb


# Read the input transcript file
input_file_path = 'data/original_transcripts/roll_for_persuasion_interview.txt'
output_file_path = 'data/cleaned_transcripts/cleaned_roll_for_persuasion_interview_transcript.txt'

File.open(output_file_path, 'w') do |output_file|
    current_speaker = nil
    current_speech = []
  
    File.foreach(input_file_path) do |line|
      # Remove newline characters at the beginning and end of the line
      line = line.chomp.lstrip.rstrip
  
      if line.match(/^(INTERVIEWER:|BRENNAN:)/)
        # If there's a current speaker and speech, write them to the output
        if current_speaker && !current_speech.empty?
          output_file.puts("#{current_speaker} #{current_speech.join(' ')}\n")
          output_file.puts("\n")  # Add a blank line between speakers
        end
        
        # Set the current speaker
        current_speaker = line
        current_speech = []
      elsif !line.match(/^\d{1,2}:\d{2}$/)  # Exclude lines that start with timestamps
        # Collect the speech lines for the current speaker
        current_speech << line
      end
    end
  
    # Write the last speaker's lines to the output
    if current_speaker && !current_speech.empty?
      output_file.puts("#{current_speaker} #{current_speech.join(' ')}")
    end
end  

puts 'Timestamps removed and transcript formatted as requested. Cleaned transcript saved to "cleaned_transcript.txt".'
