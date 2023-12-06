# run_pipeline.rb
# accepts multiple file paths from the command line, treats them as an array.

def run_pipeline(transcript_paths)
    transcript_paths.each do |original_transcript_name|
        # Step 1: Timestamp Removal
        load 'preprocess/timestamp_remover.rb'
        load 'preprocess/transcript_processor.rb'
        load 'preprocess/NLPpreprocessor.rb'
        load 'preprocess/vocab_generator.rb'

        cleaned_transcript_file_name = remove_timestamps(original_transcript_name)
        processed_transcript = process_transcript(cleaned_transcript_file_name)
        stemmed_processed_transcript = nlp_preprocess(processed_transcript)
        generate_vocab(stemmed_processed_transcript)
    end
  end
  
  if __FILE__ == $0
    # Get transcript paths from command line arguments
    transcript_paths = ARGV
  
    # Check if at least one argument (transcript path) is provided
    if transcript_paths.empty?
      puts "Usage: ruby run_pipeline.rb transcript_path1.txt [transcript_path2.txt ...]"
      exit
    end
  
    run_pipeline(transcript_paths)
  end
  