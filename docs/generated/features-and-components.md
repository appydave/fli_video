## Features

### Feature <-> DSL GPTs
https://chat.openai.com/g/g-AyFi0UOXn-code-simplifier

**Read Global Configuration**
Access and apply global configuration settings for video asset management and state consistency.

**Project Configuration**
Access and apply video or episode settings and state.

**FileWatch Processor for File Event Commands**
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

**CLI Project Management Interface**
Efficiently execute and manage video project commands using a command-line interface, enhancing control and flexibility in project handling.

**Web Command Interface for Video Project Management**
Introduce a streamlined, web-based interface for managing video project commands, enabling efficient control and organization of project components through simple browser interactions.

**Project Meta Report**
Generate a detailed report for a specific video project, including the episodes, chapters, recordings, a list of recording IDs (chapter sequence + part sequence), and the name for the next video recording, file sizes.
This should be extracted to an AstroJS Website or HTML template servered by a local webserver and provide viewing and navigation for all my video projects.


## Klue Components

Klue Component: `add_episode.klue`

```ruby
component :add_episode do
  desc "Add a new episode to an existing podcast project."

  pattern "Interactor"

  comments <<~TEXT
    - Facilitates the addition of a new episode to a specific podcast project.
    - Requires the project code of the podcast to ensure correct association.
    - Allows setting of episode-specific details like episode code and name.
    - Ensures that the episode is added only to podcast projects and not to other project types.
    - Will create recording, chapter and support folders for the episode.
  TEXT

  method :run(:project_code, :episode_code, :episode_name)

  sample :add_episode_to_podcast, <<~RUBY
    # Add a new episode to existing podcast folder
    add_episode.run('a21', '01', 'Episode About Something')
    # Create:
    # ~/video-projects/a21-ac-some-podcast/01-episode-about-something/assets
    # ~/video-projects/a21-ac-some-podcast/01-episode-about-something/chapters
    # ~/video-projects/a21-ac-some-podcast/01-episode-about-something/recordings
    # ~/video-projects/a21-ac-some-podcast/01-episode-about-something/.trash
  RUBY
end
```

Klue Component: `change_chapter_name.klue`

```ruby
component :change_chapter_name do
  desc "Alter the name of a chapter based on its sequence in the project, facilitating better organization and identification of video content."

  pattern "Command"
  note "This should be a method on the project"

  comments <<~TEXT
    - Allows the renaming of a chapter within a video project.
    - Utilizes the chapter's sequence number to identify and target the specific chapter for renaming.
  TEXT

  method :rename_chapter(:parent, :chapter_sequence, :new_name)

  <<~FILE_SYSTEM
    01-a-introduction-GPTIMPROVE.mov
    01-b-introduction-more-content.mov
    01-c-introduction.mov
    01-d-introduction-CTA.mov
    02-a-overview.mov
    03-a-scenario-TITLE.mov
  FILE_SYSTEM

  sample :change_chapter_name_in_project, <<~RUBY
    # Example of changing the name of a specific chapter in a project
    change_chapter_name.rename_chapter('a27', '01', 'intro')

    # 01-a-intro-GPTIMPROVE.mov
    # 01-b-intro.mov
    # 01-c-intro.mov
    # 01-d-intro-CTA.mov
  RUBY
end
```

Klue Component: `create_chapter_video.klue`

```ruby
component :create_chapter_video do
  desc "Combine and all video parts for a chapter sequence and put into the chapters folder."

  pattern "Command"

  comments <<~TEXT
    - Combines individual video segments into a single chapter video.
    - Facilitates independent review and editing of each chapter.
  TEXT

  constructor(:parent_project)

  method :run(:chapter_seq)

  sample :create_chapter_video, <<~RUBY
    project_path = ProjectPath.new('a27')

    # Instantiate the component with the parent project
    create_chapter_video = generate_chapter_video.new(project_path)

    # Automatically combine all video segments for a chapter
    create_chapter_video.run(1)
    # Output: '~/video-projects/a27-ac-some-podcast/chapters/01-complete-chapter.mov'
  RUBY

  sample :create_chapter_video_for_segments, <<~RUBY
    project_path = ProjectPath.new('a27')

    create_chapter_video = generate_chapter_video.new(project_path)

    create_chapter_video.run(1, ['01-intro-a.mov', '02-intro-b.mov'], output_file_name: '01-intro-custom.mov')
    # Output: '~/video-projects/a27-ac-some-podcast/chapters/01-intro-custom.mov'
  RUBY
end
```

Klue Component: `create_project.klue`

```ruby
component :create_project do
  desc "Setup a new video project for standalone YouTube video or Podcast."

  pattern "Interactor"

  comments <<~TEXT
    - Allows the creation of a new project, specifying if it's for a YouTube video or a Podcast.
    - For YouTube videos, the project will be single-episode based.
    - For Podcasts, the project can include multiple episodes.
    - Stores project-specific settings and metadata.
    - Will create recording, chapter and support folders for project_type: video
  TEXT

  enum :project_type, %w(video podcast)

  method :run(:project_type, :project_code, :channel_code, :project_name)

  sample :new_video_project, <<~RUBY
    # Create a new video project for AppyDave
    create_project.run(:video, 'a20', 'ad', 'Some Video')
    # Create: 
    # ~/video-projects/a20-ad-some-video
    # ~/video-projects/a20-ad-some-video/.fv.json
    # ~/video-projects/a20-ad-some-video/assets
    # ~/video-projects/a20-ad-some-video/chapters
    # ~/video-projects/a20-ad-some-video/recordings
    # ~/video-projects/a20-ad-some-video/.trash
  RUBY

  sample :new_podcast_project, <<~RUBY
    # Create a new podcast project for AppyCast
    create_project.run(:podcast, 'a21', 'ac', 'Some Podcast')
    # Creates folder:
    # ~/video-projects/a21-ac-some-podcast
    # ~/video-projects/a21-ac-some-podcast/.fv.json
    RUBY
end
```

Klue Component: `empty_trash.klue`

```ruby
component :empty_trash do
  desc "Permanently delete video takes from the '.trash' folder."

  pattern "Command"

  comments <<~TEXT
    - Permanently removes all recordings from the trash folder.
    - Frees up storage space by deleting unnecessary files.
    - Maintains project clarity by clearing clutter.
    - Ensures that only unwanted takes are deleted after a final review.
  TEXT

  constructor(:parent_project)

  method :run

  sample :permanently_delete_trash, <<~RUBY
    project_path = ProjectPath.new('a27')
    
    # Permanently deleting all contents of the trash folder
    clean_trash.empty_trash
    # Empties the entire .trash folder in "~/video-projects/a27-ac-categorize-mp4-CI/.trash/
  RUBY
end
```

Klue Component: `episode_path.klue`

```ruby
component :episode_path do
  desc "Construct episode path using project/episode code and deducing state based on existing folder name."

  pattern "Adapter"

  comments <<~TEXT
    - Infers episode path based on episode code and existing folder name.
    - Maintains state for episode code and descriptive name and keywords.
    - Will use current project code if not provided.
    - Path is relative to project path.
    - Uses existing folder name and keywords to build internal state.
    - Provides method for building absolute, relative and sub folder.
    - Provides method for building a new path for rename operations.
    - Provides access to associated project.
    - Stores state in an internal data object.
    - Designed for building folder names, not create or modify actual directories.
    TEXT

  accessors :episode_code, :episode_name, :keywords, :episode_path, :project

  method :constructor(:episode_code, episode_name: nil, keywords: nil, project_code: nil)
  method :instance(:folder)

  method :change_path(episode_code: nil, episode_name: nil, keywords: nil)

  # project_path.recording_path # => "~/video-projects/a27-ac-categorize-mp4-CI/recordings"
                                    # ~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO/recordings

  sample :create_episode_path, <<~RUBY
    # Create a new episode path
    episode_path = EpisodePath.new('01', episode_name: 'flivideo-project-kickoff', keywords: ['TODO'] )
    episode_path.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO"
    episode_path.episode_code # => "01"
    episode_path.episode_name # => "flivideo-project-kickoff"
    episode_path.keywords # => ["TODO"]

    project_path = episode_path.project
    project_path.project_path # => "~/video-projects/a27-ac-categorize-mp4-CI"
  RUBY

  sample :infer_episode_path, <<~RUBY
    # Infer episode path based on episode code and existing folder
    episode_path = EpisodePath.new('01')
    episode_path.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO"
    episode_path.episode_code # => "01"
    episode_path.episode_name # => "flivideo-project-kickoff"
    episode_path.keywords # => ["TODO"]

  RUBY

  sample :rename_episode_path, <<~RUBY
    # Rename episode path
    episode1 = EpisodePath.new('01')
    episode1.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO"

    episode2 = episode1.change_path(episode_code: '02')
    episode2.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/02-flivideo-project-kickoff-TODO"

    episode3 = episode1.change_path(episode_code: '03', episode_name: 'build-gpts', keywords: [])
    episode3.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/03-build-gpts"
  RUBY

  sample :next_episode_code, <<~RUBY
    # Get next episode code
    episode_path = EpisodePath.new('01')
    episode_path.next_episode_code # => "02"
  RUBY

  sample :folder_to_episode_path, <<~RUBY
    # Convert folder to episode path
    episode_path = EpisodePath.instance('~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO')
    episode_path.episode_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff-TODO"
    episode_path.episode_code # => "01"
    episode_path.episode_name # => "flivideo-project-kickoff"
    episode_path.keywords # => ["TODO"]
  RUBY
end
```

Klue Component: `global_config.klue`

```ruby
component :global_configuation do
  pattern "Singleton"

  desc "Access and apply global configuration settings for video asset management and state consistency."

  comments <<~TEXT
    Configuration file path: ~/.fli-video.json
    - Automatically creates a configuration file if it does not exist.
    - Responsible for reading and updating global configuration.
    - Provides methods to manage folder paths and various settings.
  TEXT

  sample :configuration, <<~JSON
  {
    "folders": {
      "ecamm-recordings": "~/Movies/Ecamm Live Recordings",
      "project-root": "/Volumes/Expansion/Sync/tube-channels/a-cast/cast-active",
    },
    "settings": {
      "focus-project-code": "a27",
    },
  }
  JSON

  method :set_folder(:key, :folder)
  method :folder(:key)
  method :set_setting(:key, :value)
  method :setting(:key)
  method :load
  method :save
end
```

Klue Component: `move_ecamm_file.klue`

```ruby
component :move_ecamm_file do
  desc "Seamlessly transfer eCamm recordings to the current focused video or podcast episode recordings subfolder."

  comments <<~TEXT
    - Facilitates the transfer of eCamm recording files to the appropriate project's recording subfolder.
    - Automatically identifies the current focused project or episode to ensure correct file placement.
    - Handles the file transfer process, maintaining file integrity and updating any necessary metadata.
    - Uses global configuration to determine eCamm recording folder location.
    - Uses current project configuration to determine recording subfolder location.
    - Aborts the transfer process if target folder does not exist.
  TEXT

  method :execute(:ecamm_file_name)

  sample :move_ecamm_file_to_project, <<~RUBY
    # Move an eCamm recording to the currently focused project's recordings subfolder
    move_ecamm_file.execute('Ecamm Live Recording on 2023-08-25 at 14.51.58.mov')

    # ~/video-projects/a20-ad-some-video/recordings/Ecamm Live Recording on 2023-08-25 at 14.51.58.mov
  RUBY
end
```

Klue Component: `move_to_trash.klue`

```ruby
component :move_to_trash do
  desc "Move suboptimal video takes to '.trash' folder"

  pattern "Command"

  comments <<~TEXT
    - Will trash a specific recording in a project folder.
    - Will identify the last eCamm recording in a project folder if no specific recording is provided.
    - Enhances project clarity and organization.
  TEXT

  constructure(:parent_project)

  method :run(:file_name)

  sample :move_video_to_trash, <<~RUBY
    project_path = ProjectPath.new('a27')

    command = move_to_trash.new(project_path)
  
    # Example of moving a specific suboptimal video take to the trash folder
    command.run('01-a-introduction.mov')
    # => "~/video-projects/a27-ac-categorize-mp4-CI/.trash/01-a-introduction.mov"

    # Example of moving the last suboptimal video take to the trash folder
    command.run
    # => "~/video-projects/a27-ac-categorize-mp4-CI/.trash/Ecamm Live Recording on 2023-08-25 at 14.51.58.mov
  RUBY
end
```

Klue Component: `open_in_finder.klue`

```ruby
component :open_in_finder do
  desc "Quickly access video project and episode folders within the Finder."

  pattern "Command"

  comments <<~TEXT
    - Provides shortcuts to open project and episode folders in the Finder.
    - Enhances efficiency in navigating to specific video project locations.
    - Streamlines the process of locating and managing video files and folders.
  TEXT

  constructor(:parent_project)

  method :run

  sample :access_project_in_finder, <<~RUBY
    project_path = ProjectPath.new('a27')

    command = open_in_finder.new(project_path)
    # Opens the folder for project 'a27' in Finder

    command.run
    # Opens the folder for episode '01' of project 'a27' in Finder
  RUBY
end
```

Klue Component: `project_config.klue`

```ruby
component :project_configuration do
  desc "Manage project / episode settings and state."

  pattern "Adapter"

  comments <<~TEXT
    Configuration file: .fv.json
    - Handles settings for single videos or the episodes in a Podcast.
    - Responsible for reading and updating settings.
    - Supports state management for single video, episodes, recording and chapter progression.
    - This class is a reflection of the configuration file and the folders and files it manages.

    Project type: video
    - A single video file.
    - Supports recording and chapter progression

    Project type: podcast
    - Multiple video files known as episodes.
    - Supports recording and chapter progression for each episode.

    Infers project type from the presence of the "episodes" key.
    Infers project name from the name of the folder containing the configuration file.
    Infers episode name from the name of the folder containing the video file.
    Keeps track of prefered chapter name for each chapter sequence.
  TEXT

  method :load
  method :save
  method :resync_project_files()        # refreshes the configuration based on the file system
  method :current_chapter()             # if type == :video
  method :current_episode()             # if type == :podcast

  data_object :project_config do
    constructor(:json)

    attribute :type                     # video, podcast
    attribute :code
    attribute :chapters                 # if type == :video
    attribute :episodes                 # if type == :podcast
  end

  data_object :episode_config do
    constructor(:json)

    attribute :seq                      # episode number store as number, but displayed as 2 digit string
    attribute :chapters
    attribute :current                  # true if this is the current episode

    method :current_chapter()
  end

  data_object :chapter_config do
    constructor(:json)

    attribute :seq
    attribute :preferred_name
    attribute :current                  # true if this is the current chapter
  end

  sample :configuration, :for_video, <<~JSON
  {
    "type": "video",
    "code": "e28",
    "chapters": [
      {
        seq: 1,
        preferred_name: "intro"
      },
      {
        seq: 2,
        preferred_name: "example"
      },
      {
        seq: 3,
        preferred_name: "outro",
        current: true
      }
    ]
  }
  JSON

  sample :configuration, :for_podcast, <<~JSON
  {
    "type": "podcast",
    "code": "e27",
    "episodes": [
      {
        "seq": 1,
        "chapters": [
          {
            "seq": 1,
            "preferred_name": "introduction",
          },
          {
            "seq": 2,
            "preferred_name": "scenario",
            "current": true
          }
        ]
      },
      {
        "seq": 2,
        "current": true,
        "chapters": [
          {
            "seq": 1,
            "preferred_name": "introduction",
          },
          {
            "seq": 2,
            "preferred_name": "scenario",
          },
          {
            "seq": 3,
            "preferred_name": "story",
            "current": true
          }
        ]
      }
    ]
  }
  JSON
end
```

Klue Component: `project_meta_data_store.klue`

```ruby
component :project_meta_data_store do
  desc "Build a JSON datastore of project files with inferred metadata."

  pattern "Command"

  comments <<~TEXT
    - Aggregates file data from project, episode, recording, chapter, and post-produced folders.
    - Infers metadata from sources like KEYWORDS, transcripts, and other relevant data.
    - Creates a comprehensive JSON datastore for the entire project.
    - Facilitates advanced data analysis and management for the project.
    - The extracted data can be used for automated post-production processes like keyword generation, B-roll prompts, chapter names, title slides, and time code markers for calls to action.
  TEXT

  constructor(:parent_project)

  method :run

  sample :build_project_metadata, <<~RUBY
    project_path = ProjectPath.new('a27')

    # Instantiate the component with the parent project
    metadata_store = project_meta_data_store.new(project_path)

    # Execute the process to aggregate files and infer metadata
    metadata_store.run
    # Output: '~/video-projects/a27-ac-categorize-mp4-CI/project_metadata.json'
    RUBY
end
```

Klue Component: `project_path.klue`

```ruby
component :project_path do
  desc "Construct project path using project code and deducing state based on existing folder name."

  pattern "Adapter"

  comments <<~TEXT
    - Infers project path based on project code and existing folder name.
    - Maintains state for project code, channel code, descriptive name, keywords and episodes.
    - Uses global configuration to determine root folder.
    - Uses existing folder name and keywords to build internal state.
    - Provides method for building absolute, relative and sub folder.
    - Provides method for building new path for rename operations.
    - Provides list of associated episode paths.
    - Stores state in an internal data object.
    - Designed for building folder names, not create or modify actual directories.
  TEXT

  accessors :project_code, :channel_code, :project_name, :keywords, :project_path, :episodes

  method :constructor(:project_code, channel_code: nil, project_name: nil, keywords: nil)
  method :instance(:folder)

  method :change_path(project_code: nil, channel_code: nil, project_name: nil, keywords: nil)

  sample :create_project_path, <<~RUBY
    # Create a new project path
    project_path = ProjectPath.new('a27', channel_code: 'ac', project_name: 'categorize-mp4', keywords: ['CI'] )
    project_path.project_path # => "~/video-projects/a27-ac-categorize-mp4-CI"
    project_path.project_code # => "a27"
    project_path.channel_code # => "ac"
    project_path.project_name # => "categorize-mp4"
    project_path.keywords # => "CI"
    project_path.episodes.count # => 0
  RUBY

  sample :infer_project_path, <<~RUBY
    # Infer project path based on project code and existing folder
    project_path = ProjectPath.new('a27')
    project_path.project_path # => "~/video-projects/a27-ac-categorize-mp4-CI"
    project_path.project_code # => "a27"
    project_path.channel_code # => "ac"
    project_path.project_name # => "categorize-mp4"
    project_path.keywords # => "CI"
    project_path.episodes.count # => 2
  RUBY

  sample :rename_project_path, <<~RUBY
    # Rename project path
    project_path = ProjectPath.new('a27')

    path1 = project_path.change_path(project_code: 'a28')
    path1.project_path # => "~/video-projects/a28-ac-categorize-mp4-CI"
    path2 = project_path.change_path(channel_code: 'ad', project_name: 'categorize-mp4-for-appydave')
    path2.project_path # => "~/video-projects/a27-ad-categorize-mp4-for-appydave-CI"
    path3 = project_path.change_path(keywords: [])
    path3.project_path # => "~/video-projects/a27-ac-categorize-mp4"
  RUBY

  sample :next_project_code, <<~RUBY
    # Get next project code
    project_path = ProjectPath.new('a27')
    project_path.next_project_code # => "a28"

    project_path = ProjectPath.new('a99')
    project_path.next_project_code # => "b00"
  RUBY

  sample :folder_to_project_path, <<~RUBY
    # Convert folder to project path
    project_path = ProjectPath.instance('~/video-projects/a27-ac-categorize-mp4-CI')
    project_path.project_path # => "~/video-projects/a27-ac-categorize-mp4-CI"
    project_path.project_code # => "a27"
    project_path.channel_code # => "ac"
    project_path.project_name # => "categorize-mp4"
    project_path.keywords # => "CI"
  RUBY
end
```

Klue Component: `recording_file_watcher.klue`

```ruby
component :filewatch_processor do
  desc "Automate file event responses, directing new recordings to current project folders."

  pattern "Observer"

  comments <<~TEXT
    - Monitors new eCamm recordings file events.
    - Automates the process of moving new recordings to specified project folders.
    - Enhances content management by ensuring recordings are organized efficiently.
    - Configurable to respond to different types of file events and target folders.
  TEXT

  method :watch(:folder_path, :event_type)

  # Will move the file to current project's recordings folder
  method :move_file

  sample :automate_recording_organization, <<~RUBY
    config = GlobalConfig.instance
    
    # Watch a specific folder for new and existing recordings
    filewatch_processor.watch(config.folders['ecamm-recordings'], '*.mov', :moved_file)

    # Example usage
    # When a new file is detected in Ecamm Live Recordings, it is automatically moved to the current project's recordings folder.
    filewatch_processor.move_file
  RUBY
end
```

Klue Component: `recording_filename.klue`

```ruby
component :recording_filename do
  desc "Calculate the next video recording file name based on chapter sequence, part number, chapter name, and tags if available."

  pattern "Adapter"

  comments <<~TEXT
    - File name construction for new and existing video recordings.
    - Utilizes the chapter and part sequence for systematic naming.
    - Incorporates the chapter name for descriptive clarity.
    - Has support for tags in the file name to aid content identification and post-processing workflows.
    - Set episode & project via the episode if recording belongs to an episode
    - Set project if recording belongs to a project
    - Parent returns episode || project
  TEXT

  accessors :chapter_seq, :part_seq, :chapter_name, :tags, :filename, :episode, :project, :parent

  method :constructor(:chapter_seq, :part_seq, :chapter_name, tags: [], parent: nil)
  method :instance(:full_path)

  # Use the current chapter sequence if not provided
  # Part sequence will increment based on the previous part letter in the chapter if not provided
  # Chapter name will defaults to previous recording chapter name if not provided
  method :next_filename(:previous_filename, chapter_name: nil, tags: [], chapter_seq: nil, part_seq: nil)
  method :update_chapter_sequence(:current_chapter_seq, :new_chapter_seq)
  method :resequence_chapters(:starting_chapter_seq)
  method :update_tags(:new_tags)

  sample :create_recording_filename, <<~RUBY
    project_path = ProjectPath.new('a27')
    project_path.project_path # => "~/video-projects/a27-ac-categorize-mp4-CI"

    # Generate a filename for a new video recording
    filename1 = RecordingFilename.new(1, 'a' 'introduction', tags: [], parent: project_path)
    filename1.filename # => "01-a-introduction.mov"
    filename1.chapter_seq # => 1
    filename1.part_seq # => "a"
    filename1.chapter_name # => "introduction"
    filename1.tags # => []
    filename1.full_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov"
  RUBY

  sample :next_recording_filename, <<~RUBY
    filename1 = "~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov"

    project = ProjectConfig.new('a27')

    # Class method to generate a filename for a new video recording
    filename2 = RecordingFilename.next_filename(filename1, chapter_name: 'introduction-more-content', tags: ['GPTIMPROVE'])

    # Fluent method to generate a filename for a new video recording
    filename3 = filename2.next_filename(chapter_name: 'introduction')
    filename4 = filename3.next_filename(tags: ['CTA'])

    project.next_chapter('overview')

    filename5 = RecordingFilename.next_filename(project.last_file)

    project.next_chapter('scenario')

    filename6 = RecordingFilename.next_filename(project.last_file, tags: ['TITLE'])

    filename1.filename # => "01-a-introduction-GPTIMPROVE.mov"      # Send transcription to GPT Bot for improvement
    filename2.filename # => "01-b-introduction-more-content.mov"
    filename3.filename # => "01-c-introduction.mov"
    filename4.filename # => "01-d-introduction-CTA.mov"             # Instruction for video editor to add a CTA
    filename5.filename # => "02-a-overview.mov"
    filename6.filename # => "03-a-scenario-TITLE.mov"               # Instruction for video editor to add a title slide
  RUBY

  sample :file_to_recording_filename, <<~RUBY
    # Convert absolute file to recording filename
    filename = RecordingFilename.instance('~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov')

    filename.filename # => "01-a-introduction.mov"
    filename.chapter_seq # => 1
    filename.part_seq # => "a"
    filename.chapter_name # => "introduction"
    filename.tags # => []
    filename.full_path # => "~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov"
  RUBY

  sample :rename_recording_filename, <<~RUBY
    filename = RecordingFilename.instance('~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov')
    filename.filename # => "01-a-introduction.mov"

    filename.change_filename(chapter_name: 'introduction-trim-23s', tags: ['GPTDALE3'])
    filename.filename # => "01-a-introduction-trim-23s-GPTDALE3.mov"
  RUBY

  sample :update_chapter_sequence, <<~RUBY
    project_path = ProjectPath.new('a27')

    # Update chapter sequence in a project
    filename = RecordingFilename.new(2, 'b', 'overview', parent: project_path)
    filename.update_chapter_sequence(2, 3)
    filename.filename # => "03-b-overview.mov"
  RUBY

  sample :resequence_chapters, <<~RUBY
    # Resequence chapters starting from a given sequence
    filename.resequence_chapters(2)
    # Adjusts chapter sequence of all subsequent chapters starting from '02'
  RUBY

  sample :update_tags, <<~RUBY
    # Update tags for a recording
    filename = RecordingFilename.new(1, 'a', 'introduction', tags: ['OLD_TAG'], parent: project_path)
    filename.update_tags(['NEW_TAG'])
    filename.filename # => "01-a-introduction-NEW_TAG.mov"
  RUBY
end
```

Klue Component: `restore_from_trash.klue`

```ruby
component :restore_from_trash do
  desc "Retrieve video takes from '.trash' folder and move them back to the project folder."

  pattern "Command"

  comments <<~TEXT
    - Restores a specific recording from the trash to the project folder.
    - If no specific recording is provided, restores the most recently trashed recording.
    - Facilitates reconsideration or re-evaluation of previously discarded content.
  TEXT

  constructor(:parent_project)

  method :run(:file_name)

  sample :restore_from_trash, <<~RUBY
    project_path = ProjectPath.new('a27')

    command = undo_trash.new(project_path)

    # Example of restoring a specific recording from the trash folder
    command.run('01-a-introduction.mov')
    # => "~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov"

    # Example of restoring the most recently trashed recording
    command.run
    # => "~/video-projects/a27-ac-categorize-mp4-CI/Ecamm Live Recording on 2023-08-25 at 14.51.58.mov"
  RUBY
end
```

Klue Component: `switch_focus.klue`

```ruby
component :change_focus do
  desc "Easily switch between different video projects or episodes to accommodate changing content priorities."

  pattern "Interactor"

  comments <<~TEXT
    - Allows switching the focus to a different video project or a specific episode within a podcast.
    - Video recordings belong to a specific project or episode and this interaction ensures that the correct project or episode is in focus.
    - Ensures seamless transition and updates the working context to the selected project or episode.
    - Maintains state consistency across switches using the global configuration.
  TEXT

  method :run(:project_code, episode_code: nil)

  sample :switch_focus_to_video_project, <<~RUBY
    # Switch focus to a different video project
    change_focus.run('a20')
  RUBY

  sample :switch_focus_to_podcast_episode, <<~RUBY
    # Switch focus to a specific episode within a podcast project
    change_focus.run('a21', '02')
  RUBY
end
```

Klue Component: `text_to_speech.klue`

```ruby
component :text_to_speech do
  desc "Transcribe spoken content to text and store in multiple transcription formats."

  pattern "Command"

  comments <<~TEXT
    - Transcribes audio content from videos into text.
    - Supports storing transcriptions in various formats for accessibility and further processing.
    - Uses the transcript folder under the recording, chapter or post-production folder and stores the transcriptions in a subfolder called 'transcript'.
  TEXT

  constructor(:parent_project)

  method :run(:recording_file, output_formats:)

  sample :transcribe_audio_to_text, <<~RUBY
    project_path = ProjectPath.new('a27')

    # ~/video-projects/a27-ac-categorize-mp4-CI/01-a-introduction.mov
    # Instantiate the component with the parent project
    tts = text_to_speech.new(project_path)

    # Execute the transcription against
    tts.run('01-introduction.mov', output_formats: ['txt', 'srt', 'vtt', 'json', 'tsv'])

    # Transcribes '01-introduction.mov' and stores the transcriptions in the specified formats
    # Output: Transcriptions saved in '~/video-projects/a27-ac-categorize-mp4-CI/recordings/transcript/01-introduction.txt|srt|vtt|json|tsv'
  RUBY
end
```

Klue Component: `transcript_data_store.klue`

```ruby
component :transcript_data_store do
  desc "Build a JSON datastore of transcripts for an entire project."

  pattern "Command"

  comments <<~TEXT
    - Aggregates transcripts from various project levels into a single JSON datastore.
    - Scans project, episode, recording, chapter, and post-produced folders for existing transcripts.
    - Facilitates easy access and management of transcript data across the entire project.
    - Enhances data retrieval and analysis capabilities for the project's transcripts.
    - Stores data in a JSON file called 'transcripts.json' in the project folder.
  TEXT

  constructor(:parent_project)

  method :run

  sample :build_transcript_datastore, <<~RUBY
    project_path = ProjectPath.new('a27')

    # Instantiate the component with the parent project
    transcript_store = transcript_data_store.new(project_path)

    # Execute the process to aggregate and store transcript data
    transcript_store.run
    # Output: '~/video-projects/a27-ac-categorize-mp4-CI/project_transcripts.json'
  RUBY
end
```

