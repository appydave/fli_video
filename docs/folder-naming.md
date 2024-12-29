### Folder Naming Conventions

#### Overview

The component will generate standardized names for projects, episodes, and recordings within the YouTube content creation process. It will ensure consistency and clarity across all naming elements, adhering to the specified conventions and accommodating optional tags for recordings.

---

#### 1. Project Naming

**Input Parameters:**

- **Sequence:** A unique alphanumeric identifier starting from `a00` to `a99`, rolling over to `b00` after `a99`.
- **Channel Code (Optional):** A short code denoting the channel or project type (e.g., `xmen`).
- **Project Name:** A descriptive name for the project (e.g., `my-video-project`).

**Output:**
A string combining the input parameters in the format:

```
{Sequence}-{ChannelCode}-{ProjectName}
```

If the Channel Code is omitted:

```
{Sequence}-{ProjectName}
```

**Examples:**

- Input: `Sequence = 'a27', ChannelCode = 'xmen', ProjectName = 'my-video-project'`
  - Output: `a27-xmen-my-video-project`
- Input: `Sequence = 'a27', ProjectName = 'my-video-project'`
  - Output: `a27-my-video-project`

**Example Code:**

```ruby
def generate_project_name(sequence, project_name, channel_code=nil)
  if channel_code
    "\#{sequence}-\#{channel_code}-\#{project_name}"
  else
    "\#{sequence}-\#{project_name}"
  end
end
```

---

#### 2. Episode Naming

**Input Parameters:**

- **Sequence:** A numeric identifier representing the episode order (e.g., `01`, `02`).
- **Episode Name:** A descriptive name for the episode (e.g., `flivideo-project-kickoff`).

**Output:**
A string combining the input parameters in the format:

```
{Sequence}-{EpisodeName}
```

**Example:**

- Input: `Sequence = '01', EpisodeName = 'flivideo-project-kickoff'`
  - Output: `01-flivideo-project-kickoff`

**Example Code:**

```ruby
def generate_episode_name(sequence, episode_name)
  "\#{sequence}-\#{episode_name}"
end
```

---

#### 3. Recording Naming with Tags

**Input Parameters:**

- **Chapter Sequence:** A numeric identifier representing the chapter order (e.g., `03`).
- **Subsequence:** A letter representing the sequence of variations for the chapter (e.g., `a`, `b`).
- **Chapter Name:** The base name of the chapter (e.g., `outro`).
- **Tags (Optional):** An array of tags describing variations or specific attributes of the recording (e.g., `['cta', 'endcards']`).

**Output:**
A string combining the input parameters in the format:

```
{ChapterSequence}-{Subsequence}-{ChapterName}-{Tag1}-{Tag2}.mov
```

If no tags are present:

```
{ChapterSequence}-{Subsequence}-{ChapterName}.mov
```

**Examples:**

- Input: `ChapterSequence = '03', Subsequence = 'a', ChapterName = 'outro'`
  - Output: `03-a-outro.mov`
- Input: `ChapterSequence = '03', Subsequence = 'b', ChapterName = 'outro', Tags = ['cta']`
  - Output: `03-b-outro-cta.mov`
- Input: `ChapterSequence = '03', Subsequence = 'b', ChapterName = 'outro', Tags = ['endcards']`
  - Output: `03-b-outro-endcards.mov`

**Tag Handling:**

- Tags must be pre-configured in the application to allow automatic parsing and separation from chapter names.
- **Examples of pre-configured tags:**
  - `cta` (Call to Action)
  - `endcards` (Additional video references)

**Example Code:**

```ruby
def generate_recording_name(chapter_sequence, subsequence, chapter_name, tags=[])
  if tags.any?
    "\#{chapter_sequence}-\#{subsequence}-\#{chapter_name}-\#{tags.join('-')}.mov"
  else
    "\#{chapter_sequence}-\#{subsequence}-\#{chapter_name}.mov"
  end
end
```

---

#### 4. Folder Structure

**Input Parameters:**

- **Project Name:** The full name of the project generated from the project naming component.
- **Episode Names:** A list of episode names generated from the episode naming component.
- **Recording Names:** A list of recording names generated from the recording naming component.

**Output:**
A nested folder structure representing the project, episodes, and recordings. `.trash` folders are created on demand at the level of a video recording to store bad takes when necessary, ensuring they are not automatically included.

**Example:**

**For a single video project:**

```
a27-xmen-my-video-project/
├── recordings/
│   ├── 01-introduction.mov
│   ├── 02-a-content.mov
│   ├── 02-b-content.mov
│   ├── 03-a-outro.mov
│   ├── 03-b-outro-cta.mov
│   ├── .trash/
│   │   ├── bad-take-01.mov
```

**For a multiple episodes project:**

```
a27-xmen-my-video-project/
├── 01-flivideo-project-kickoff/
│   ├── recordings/
│   │   ├── 01-introduction.mov
│   │   ├── 02-a-content.mov
│   │   ├── 02-b-content.mov
│   │   ├── 03-a-outro.mov
│   │   ├── 03-b-outro-cta.mov
│   │   ├── .trash/
│   │   │   ├── bad-take-02.mov
├── 02-different-episode-name/
│   ├── recordings/
│   │   ├── 01-introduction.mov
│   │   ├── 02-content.mov
│   │   ├── 03-a-outro.mov
│   │   ├── .trash/
│   │   │   ├── bad-take-03.mov
```

---

#### 5. Reverse Engineering

**Input Parameters:**

- A string representing a name in its format (e.g., `a27-xmen-my-video-project`, `03-b-outro-cta.mov`).

**Output:**
An object with the following properties:

- **Sequence:** The alphanumeric or numeric identifier.
- **Channel Code:** The channel code (if applicable).
- **Project Name:** The descriptive name of the project.
- **Chapter Sequence:** The numeric identifier for the chapter.
- **Subsequence:** The letter representing variations for the chapter.
- **Chapter Name:** The base name of the chapter.
- **Tags:** An array of tags (if present).

**Examples:**

- Input: `a27-xmen-my-video-project`
  - Output: `{ "Sequence" => "a27", "ChannelCode" => "xmen", "ProjectName" => "my-video-project" }`
- Input: `03-b-outro-cta.mov`
  - Output: `{ "ChapterSequence" => "03", "Subsequence" => "b", "ChapterName" => "outro", "Tags" => ["cta"] }`
- Input: `03-a-outro.mov`
  - Output: `{ "ChapterSequence" => "03", "Subsequence" => "a", "ChapterName" => "outro", "Tags" => [] }`

**Example Code:**

```ruby
def reverse_engineer_project_name(project_name)
  parts = project_name.split('-')
  if parts.size == 3
    { "Sequence" => parts[0], "ChannelCode" => parts[1], "ProjectName" => parts[2] }
  else
    { "Sequence" => parts[0], "ProjectName" => parts[1] }
  end
end

def reverse_engineer_episode_name(episode_name)
  parts = episode_name.split('-')
  { "Sequence" => parts[0], "EpisodeName" => parts[1] }
end

def reverse_engineer_recording_name(recording_name)
  base_name = recording_name.chomp('.mov')
  parts = base_name.split('-')
  if parts.size > 3
    tags = parts[3..-1]
    { "ChapterSequence" => parts[0], "Subsequence" => parts[1], "ChapterName" => parts[2], "Tags" => tags }
  else
    { "ChapterSequence" => parts[0], "Subsequence" => parts[1], "ChapterName" => parts[2], "Tags" => [] }
  end
end
```

---

#### Functional Requirements

1. **Generate Project Name:**

   - Accept `Sequence`, `Channel Code` (optional), and `Project Name` as inputs.
   - Output a string in the format `{Sequence}-{ChannelCode}-{ProjectName}` or `{Sequence}-{ProjectName}` if the Channel Code is omitted.

2. **Generate Episode Name:**

   - Accept `Sequence` and `Episode Name` as inputs.
   - Output a string in the format `{Sequence}-{EpisodeName}`.

3. **Generate Recording Name:**

   - Accept `Chapter Sequence`, `Subsequence`, `Chapter Name`, and `Tags` (optional) as inputs.
   - Output a string in the format `{ChapterSequence}-{Subsequence}-{ChapterName}-{Tags}`.

4. **Create Folder Structure:**

   - Accept `Project Name`, `Episode Names`, and `Recording Names`.
   - Create a folder structure based on the provided inputs, with `.trash` folders created only when needed.

5. **Reverse Engineer Names:**

   - Accept a name string.
   - Output an object with properties of the name, including `Tags` (if present).

6. **Tag Validation:**

   - Validate tags against a predefined list of valid tags to ensure correct separation from chapter names.

---

#### Non-Functional Requirements

- **Consistency:** Ensure all generated names adhere to the defined formats.
- **Scalability:** Efficiently handle a large number of projects, episodes, and recordings.
- **User Interface:** Provide a simple and intuitive interface for inputting parameters and generating names.

---

#### Trash Folder Creation and Management

**Behavior:**

- `.trash` folders are created on demand at the level of a video recording to store discarded or bad takes.
- These folders are not automatically included in the structure but are generated only when needed.
- Bad takes can be reviewed and restored from the `.trash` folder as required.

**Simple Example:**

**Method: Move to Trash**

```ruby
def move_to_trash(recording_name, trash_folder_path)
  FileUtils.mkdir_p(trash_folder_path) unless Dir.exist?(trash_folder_path)
  FileUtils.mv(recording_name, trash_folder_path)
end
```

**Usage:**

```ruby
move_to_trash("recordings/bad-take-01.mov", "recordings/.trash")
```

**Method: Empty Trash**

```ruby
def empty_trash(trash_folder_path)
  if Dir.exist?(trash_folder_path)
    FileUtils.rm_rf(trash_folder_path)
  else
    puts "Trash folder does not exist."
  end
end
```

**Usage:**

```ruby
empty_trash("recordings/.trash")
```

**Examples:**

- `.trash` folders are created on demand at the level of a video recording to store discarded or bad takes.
- These folders are not automatically included in the structure but are generated only when needed.
- Bad takes can be reviewed and restored from the `.trash` folder as required.

**Simple Example:**

**Method:**

```ruby
def move_to_trash(recording_name, trash_folder_path)
  FileUtils.mkdir_p(trash_folder_path) unless Dir.exist?(trash_folder_path)
  FileUtils.mv(recording_name, trash_folder_path)
end
```

**Usage:**

```ruby
move_to_trash("recordings/bad-take-01.mov", "recordings/.trash")
```

**Examples:**

- `.trash` folders are created on demand at the level of a video recording to store discarded or bad takes.
- These folders are not automatically included in the structure but are generated only when needed.
- Bad takes can be reviewed and restored from the `.trash` folder as required.

**Examples:**

- A `.trash` folder is created when a bad take is identified:

```
a27-xmen-my-video-project/
├── recordings/
│   ├── .trash/
│   │   ├── bad-take-01.mov
│   ├── 01-introduction.mov
│   ├── 02-a-content.mov
```

- If no bad takes are identified, no `.trash` folder exists:

```
a27-xmen-my-video-project/
├── recordings/
│   ├── 01-introduction.mov
│   ├── 02-a-content.mov
```

