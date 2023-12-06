require 'json'

def generate_vocab(stemmed_processed_transcript)
  # Load the preprocessed Brennan transcript in JSON format
  brennan_transcript = JSON.parse(File.read("data/nlp_preprocessed_transcripts/#{stemmed_processed_transcript}.json"))
  
  # Create a vocabulary from the transcript data
  vocabulary = brennan_transcript.join(' ').split.uniq.sort
  
  # Create a word-to-index and index-to-word mapping
  word_to_index = {}
  index_to_word = {}
  
  vocabulary.each_with_index do |word, index|
    word_to_index[word] = index
    index_to_word[index] = word
  end
  
  # Save the vocabulary and mappings to files for future use
  File.write('data/vocabulary/vocabulary.json', JSON.pretty_generate(vocabulary))
  File.write('data/vocabulary/word_to_index.json', JSON.pretty_generate(word_to_index))
  File.write('data/vocabulary/index_to_word.json', JSON.pretty_generate(index_to_word))
  
  puts 'Vocabulary building completed.'
end

