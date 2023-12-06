require 'tokenizer'
require 'stemmer'
require 'json'

# Read the transcript data in JSON format
cleaned_transcript_path = "cleaned_roll_for_persuasion_interview_transcript.json"
transcript_data = JSON.parse(File.read("data/processed_transcripts/#{cleaned_transcript_path}"))

# Process only the utterances of Brennan Lee Mulligan
brennan_transcript = []

transcript_data.each do |statement|    
    # Check if the speaker is Brennan Lee Mulligan
    if statement["speaker"] == 'BRENNAN'
      text = statement['text']

      # Tokenize the text
      tokens = Tokenizer::WhitespaceTokenizer.new.tokenize(text)

      # Stem each token
      stemmed_tokens = tokens.map { |token| token.stem }

      # Add the preprocessed utterance to the Brennan transcript
      brennan_transcript << stemmed_tokens.join(' ')
    end
end

# Create a new JSON file containing only Brennan's transcript
File.write('data/nlp_preprocessed_transcripts/stemmed_brennan_transcript.json', JSON.pretty_generate(brennan_transcript))

puts 'Transcript preprocessing completed for Brennan Lee Mulligan.'
