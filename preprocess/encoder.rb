# encoder.rb

require 'json'

# Load the vocabulary and mappings
def load_vocabulary
  vocabulary = JSON.parse(File.read('transcripts/vocabulary.json'))
  word_to_index = JSON.parse(File.read('transcripts/word_to_index.json'))
  index_to_word = JSON.parse(File.read('transcripts/index_to_word.json'))
  return vocabulary, word_to_index, index_to_word
end

# Encode a text sentence using the loaded vocabulary
def encode_text(sentence, word_to_index)
  encoded_sentence = sentence.split.map { |word| word_to_index[word] }
  return encoded_sentence
end

# Main program
if __FILE__ == $0
  vocabulary, word_to_index, index_to_word = load_vocabulary
  
  # Example: Encode a sentence
  sentence = "we'll see you next week"
  encoded_sentence = encode_text(sentence, word_to_index)
  
  # Print the encoded sentence
  puts encoded_sentence
end
