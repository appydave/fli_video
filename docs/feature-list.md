## Features

### Feature <-> DSL GPTs
https://chat.openai.com/g/g-AyFi0UOXn-code-simplifier

**Global Configuration**
Access and apply global configuration settings for video asset management and state consistency.

**Project Configuration**
Access and apply video or episode settings and state. Infers project settings from existing project folders and files.

**CLI Project Commands**
Efficiently execute and manage video project commands using a command-line interface, enhancing control and flexibility in project handling.

**FileWatch Processor**
Utilize a FileWatch processor to automate file event responses, directing new recordings to designated folders for efficient content management.

**Create Project**
Setup a new video project for standalone YouTube video or Podcast.

**Add Episode**
Add a new episode to an existing podcast project.

**Switch Video Focus**
Easily switch between different video projects or episodes to accommodate changing content priorities.

**Move eCamm File**
Seamlessly transfer eCamm recordings to the current focused video or podcast episode recordings subfolder.

**Project Path**
Construct and manage project paths dynamically using configurable values and existing folder name segments.

**Episode Path**
Construct and manage episode paths dynamically using configurable values and existing folder name segments.

**Recording Namer**
Dynamically generate and update video recording filenames, incorporating chapter and part sequences, chapter names, and tags, with capabilities to modify chapter sequences and tags for improved organization and content identification.

**Change Chapter Name**
Alter the name of a chapter based on its sequence in the project, facilitating better organization and identification of video content.

**Trash**
Moves suboptimal video takes to a designated 'trash' or 'archive' folder, optimizing storage and maintaining project clarity by segregating lesser-quality content.

**Trash Undo**
Retrieves video takes from the '.trash' folder and moves them back into the target project folder, allowing for reconsideration or re-evaluation of previously discarded content.

**Clean Trash**
Permanently deletes video takes from the 'trash' or 'archive' folder, freeing up storage space and ensuring project clarity.

**Open in Finder**
Quickly access video project and episode folders within the Finder, streamlining file navigation.

**Create Chapter Video**
Combine and review video chapter segments independently, facilitating content evaluation and editing.

**Text to Speech**
Transcribe spoken content to text and store transcriptions folder in multiple transcription formats.

Create a DSL using the interactor pattern for:

**Transcript Data Store**
Builds a JSON datastore of transcripts for an entire project based on existing transcript folders found within project, episode, recording, chapter and post-produced folders.

**Project Meta Data Store**
Build a JSON datastore of files for an entire project based on existing project, episode, recording, chapter and post-produced folders and infer metadata based on KEYWORDS, transcripts or other useful data.

## Future Ideas

**Web Command Interface for Video Project Management**
Introduce a streamlined, web-based interface for managing video project commands, enabling efficient control and organization of project components through simple browser interactions.

**Project Meta Report**
Generate a detailed report for a specific video project, including the episodes, chapters, recordings, a list of recording IDs (chapter sequence + part sequence), and the name for the next video recording, file sizes.
This should be extracted to an AstroJS Website or HTML template servered by a local webserver and provide viewing and navigation for all my video projects.

