require 'json'

# Read the transcript file
transcript_file = 'transcripts.txt'
transcript_data = File.read(transcript_file)

# Initialize variables to store structured data
structured_data = []
current_speaker = nil
current_text = ''

# Regular expression to identify speakers
speaker_pattern = /^([A-Z]+): /

# Process each line in the transcript
transcript_data.each_line do |line|
  match = speaker_pattern.match(line)
  if match
    # Save the previous speaker's text
    if current_speaker
      structured_data << { "speaker" => current_speaker, "text" => current_text.strip }
    end
    # Update current speaker and reset text
    current_speaker = match[1]
    current_text = line.sub(match[0], '') # Remove the speaker's prefix
  else
    # Append text to the current speaker
    current_text += line
  end
end

# Add the last speaker's text
if current_speaker
  structured_data << { "speaker" => current_speaker, "text" => current_text.strip }
end

# Convert the structured data to JSON
json_data = JSON.pretty_generate(structured_data)

# Save the JSON data to a file
output_file = 'transcript.json'
File.write(output_file, json_data)

puts "Transcript data has been processed and saved to #{output_file}."
