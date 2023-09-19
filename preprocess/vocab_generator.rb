require 'json'

# Load the preprocessed Brennan transcript in JSON format
brennan_transcript = JSON.parse(File.read('transcripts/brennan_transcript.json'))

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
File.write('transcripts/vocabulary.json', JSON.pretty_generate(vocabulary))
File.write('transcripts/word_to_index.json', JSON.pretty_generate(word_to_index))
File.write('transcripts/index_to_word.json', JSON.pretty_generate(index_to_word))

puts 'Vocabulary building completed.'
