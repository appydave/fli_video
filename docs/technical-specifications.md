# FliVideo

## Application Overview

FliVideo is a Video Asset Managment tool created by a YouTuber `@AppyDave` for YouTubers.

It provides a set of image, video and workflow management tools to help its creator 'AppyDave' to automate and systemetize the video production process.

The intiial idea behind FliVideo was Zappier for YouTubers, but it is evolving with a range of capabilities around script, b-roll and presenation canvas automation.

### Video Recording Managment

FliVideo initially targeted video content creators using Ecamm Live on the Mac, and adaptable for OBS users.

Tailored for projects ranging from individual YouTube videos to episodes in a podcast series, the application fits seamlessly into the workflow between video recording and editing. 

It streamlines the post-recording process, encompassing file organization, renaming, and assembly of video recordings, thereby enhancing the efficiency and structure of content creation.

### Core Functionality

- **Video Management**: The application intelligently handles videos recorded via Ecamm Live. Once Ecamm saves the videos with a name and timestamp in its folder, our system relocates them to a specific project or episode folder within the project/recordings directory.
- **Project and Episode Handling**: Each video project pertains to either a single YouTube video or a series of podcast episodes. The application supports a structured approach to organizing these projects.
- **Chapter-Based Recording**: Emulating a book's structure, down to chapters and individual paragraphs or sentences, videos are recorded and categorized as chapters, which can further be divided into smaller segments or 'parts', akin to paragraphs or sentences, labeled sequentially (e.g., a, b, c...).
- **File Naming and Organization**: Adhering to a sophisticated naming convention, the application names projects using a sequence (e.g., a01..a99, b01..), a YouTube channel code (e.g., ac=AppyCast, fv=FliVideo), and specific project descriptors. This convention is applied to organize and identify video chapters and parts within each project.
- **Combining Video Chapters**: After completing recordings for a chapter, these are joined to form a new video file in the chapter's folder, enhancing content flow and consistency.
- **Speech to Text Integration**: The application features advanced speech-to-text capabilities, converting spoken content into transcriptions. These transcriptions are then utilized for various content generation scenarios, including automatic tagging, generating prompts for AI-based tools like DALL·E 3, and providing detailed instructions for video editors.

### Advanced Features

- **Dynamic Configuration**: The system adapts to various configurations set by the user before recording, using this information for subsequent file naming and routing.
- **Trash and Undo Functions**: Videos deemed suboptimal can be moved to a 'trash' folder, with the ability to undo this action if needed.
- **Automated File Processing**: Utilizing a FileWatch processor, the application automates responses to file events, like moving new recordings to designated folders.
- **Content Segmentation**: The application supports segmentation of content into sections and subparts, each with a calculated sequence number and name for easy identification and organization.
- **Metadata and Transcription Integration**: Extracting metadata from video transcriptions and file tags, the system aids in post-production processes such as keyword generation and chapter transitions.

### Organization Suited for

- Long form YouTube content
- Multi Episode Podcasts
- One off YouTube Short or multiple shorts extracted from Long Form or Episode videos
- Course Creation

## eCamm Live

I use eCamm Live to record my videos. It is simple to create videos with scenes and record individual sections of a video. This application should adapt to OBS with minimal changes.

eCamm live recording files are saved in the following format:

```bash
Ecamm Live Recording on [YYYY-MM-DD] at [HH.MM.SS].mov

# Example
Ecamm Live Recording on 2023-08-25 at 14.51.58.mov
```

## Configuration


### Global configuration

FliVideo uses a global configuration file located at `~/.fli-video.json` to store settings and paths for the application and state information such as the current project and episode. This file is created when the application is first run and is updated when the user changes the configuration.

### Project configuration

FliVideo stores project-specific settings in `.fv.json` file located in the project's root folder. This file is created when the user creates a new project and is updated when recordings are updated. This file has a section for video and a section for episodes and uses the same structure in both sections

## Project Naming and Structure

As part of the application development, each video project is assigned an alphanumeric identifier, ensuring a unique and systematic approach to project management. 

Currently, the application supports four primary project codes corresponding to distinct content areas: AppyCast, AppyDave, WinningPrompts, and FliVideo.

Each project is also given a descriptive title, providing clear and immediate insight into its content or objective. Additionally, project names may include a status or keyword, offering a quick reference to the project's current state or specific characteristics. This naming convention and structure are fundamental to the application, as they facilitate efficient organization, easy retrieval, and effective management of diverse projects, ranging from media production to targeted content creation.

### Sample project folder names 

```bash
a13-wp-openai-moderation-api-announcement-aug-25
a20-ad-open-interpreter
a21-ac-custom-gpt-instruction
a22-ac-browse-with-bing-chatgpt-feature
a24-ad-appydave-website
a26-ac-pinokio-NOT-STARTED
a27-ac-categorize-mp4-CI
a28-ac-easy-gpt-context-creation-FIND-MINDMAP
a29-ac-gpts-analyze-pdf-transations
```

### Sample project codes

- `ac` - AppyCast
- `ad` - AppyDave
- `fv` - FliVideo
- `wp` - WinningPrompts
- `c9` - Carnivore90
- `t1` - Trend10

### Video Subfolders

Within the application's structure, video subfolders play a crucial role in organizing various elements of a project. These subfolders, residing under `project-name` for single video projects or `project-name/episode-name` for podcast episodes, are named and utilized as follows:

- **recordings**: This folder contains individual labeled recordings. Each recording is meticulously named and stored here, serving as the primary repository for raw video footage.

- **chapters**: Grouped recordings that have been joined together are stored in this folder. It represents the assembled segments of a project, showcasing the progression from individual recordings to cohesive chapters.

- **.trash**: The `.trash` folder is designated for recordings considered as bad takes. This allows for an efficient way to segregate and review discarded content, keeping the main folders clutter-free while retaining the option for retrieval.

- **assets**: This folder is utilized for storing extra graphic materials or b-roll assets. These elements are crucial in the production phase of a video, enhancing the visual appeal and providing supplementary content.

- **transcription**: Transcription files, providing textual versions of the video content, are stored here. This is especially useful for accessibility, content repurposing, and as a reference during the editing process.


### Chapter naming convention

Each video project is divided into chapters, which are further segmented into parts. This structure is analogous to a book's chapters and paragraphs, respectively.

A chapter name like introduction may have additional descriptive labels like `introduction-context`, `introduction-outline`, `introduction-call-to-action`.

#### Sample chapter names

Chapter names help to identify the content of the video and maybe used for transition slide titles or chapter titles in a YouTube video.

- introduction
- overview
- example
- question
- answer
- summary
- outro

#### Why are parts important?

Too minimize the amount of editing required, I may want to record each part of a chapter separately. This allows clean recordings with minimal editing.

### Keywords and Tags

Any recording can have 1 or more tags associated with it. These tags can be used to inform the video editor to inject B-roll or be picked up by another automation such as transcribe and send to GPT Bot

#### Example Tags

- `INTRO` - This recording needs to be placed into an intro template
- `CTA` - Like/subscribe, add comment, link in description or any other call to action
- `TRIM` - This recording needs to be truncated
- `TRIM-40s` - This recording needs to be truncated to 40 seconds
- `BROLL` - This recording needs B-roll
- `TELEPROMPT` - This recording needs to be transcribed and put into the teleprompter or sent to GPT bot for script inprovement
- `OUTRO` - This recording needs to be placed into an outro template

### Scenarios

#### Long form

For full-length YouTube videos, the application offers a comprehensive solution from initial recording to final organization. It supports the creation and management of individual video projects, each with unique identifiers and descriptive names. The application's robust structure allows for the segmentation of videos into chapters and subparts, making the editing process more manageable and efficient. This scenario is ideal for YouTubers looking to produce structured, high-quality content for their channels.

#### Multi Episode Podcast

For podcasters using YouTube as their platform, the application provides excellent tools for episode management. It enables the creation of episodic content, each episode with its own identifier and title, under a single project umbrella. This scenario allows podcast creators to maintain a cohesive series, with easy navigation and organization of episodes, enhancing the listener's experience on YouTube.

#### Course Creation

In the context of online courses, the application excels in organizing and managing educational content. Course creators can structure their material into distinct sections and chapters, aligning with course modules or lessons. This scenario is particularly useful for educators and trainers who seek to provide a well-organized, accessible learning experience. The application's capabilities in handling multiple recordings and segments ensure that each part of the course is neatly cataloged and easy to access for students.

#### Short form

The application streamlines YouTube Shorts creation by allowing users to start new shorts projects or extract segments from longer videos. It enables easy segmentation, customization with intros and outros, and organizes these shorts in dedicated folders, enhancing content diversity on YouTube.

### YouTube Shorts

The application is proficiently designed to accommodate the creation of YouTube Shorts, catering to both standalone short-form videos and segments derived from longer recordings.

**Standalone Shorts**: When starting a brand-new project specifically as a YouTube Short, the process mirrors that of a regular YouTube video. The application allows for the creation, naming, and organization of these shorts in their unique project folders.

**Shorts from Longer Recordings**: In many instances, a segment within a chapter or even a single paragraph might be ideal for a YouTube Short. In such cases, the application offers the flexibility to extract and separate these segments. It allows for the recording of additional intros and outros, specifically tailoring the segment for the short-form format. These extracted segments are then organized into a dedicated folder, designated for YouTube Shorts, within the main project. This ensures that while the original recording remains an integral part of the larger video or episode, the segment is also independently accessible for the video editor to assemble into a YouTube Short.

## Project Structure Design

The following sections describe the application's structure and naming conventions using an exiting project example and highlights the system's capabilities in managing video projects and episodes.

#### Project Naming and Organization

Each project in the system is uniquely identified with a structured naming convention. For example, `a27-ac-categorize-mp4-IN-PROGRESS` breaks down as follows:

- **Sequence**: 'a27', representing the project's unique identifier.
- **Project Code**: 'ac', denoting the AppyCast channel.
- **Project Name**: 'categorize-mp4', describing the project's focus.
- **Status**: 'IN-PROGRESS', indicating the current stage of the project.

#### Episode Management

Episodes within a project are optional and are used when a project encompasses multiple videos. Each episode has its own folder named with a sequence and descriptive title, such as `01-flivideo-project-kickoff`:

- **Sequence**: '01', '02', etc., showing the episode's order in the series.
- **Episode Name**: Like 'flivideo-project-kickoff', providing a brief description of the episode's content.

#### Recordings Folder

The recordings folder, e.g., `a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff/recordings`, contains individual video files. These are named following a specific pattern:

- **Sequence and Section Name**: Starting with a number indicating their order, followed by a descriptive name, like '01-introduction.mov'.
- **Subparts**: For more detailed segmentation, files are further labeled with suffixes like '-a', '-b', '-c', indicating the subparts of a section, such as '02-a-overview.mov', '02-b-overview.mov'.

Here is an example from episode 1 of the FliVideo project Podcast.

```bash
# a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff/recordings

01-introduction.mov
02-a-overview.mov
02-b-overview.mov
02-c-overview.mov
02-d-overview.mov
02-e-overview.mov
03-a-role_CI.mov
03-b-overview_CI.mov
04-a-gpt-first-attempt.mov
04-b-gpt-first-attempt-explanation.mov
05-first-commands_TRANSITION.mov
06-a-commands_CI.mov
07-b-commands_CI.mov
07-d-commands-goal_CI.mov
08-a-response_CI-TRANSITION.mov
08-b-response_CI-TRANSITION.mov
09-a-gpt-2nd-attempt.mov
09-b-gpt-2nd-attempt.mov
09-c-gpt-2nd-attempt.mov
10-a-gpt-goal.mov
10-b-gpt-goal.mov
10-c-gpt-goal.mov
10-d-gpt-goal.mov
10-e-gpt-goal.mov
10-f-gpt-goal.mov
11-a-gpt-goal-more.mov
11-b-gpt-goal-more.mov
12-a-code-cli.mov
12-b-code-cli.mov
12-c-code-cli.mov
13-a-code-cli-run.mov
13-b-code-cli-run.mov
13-c-code-cli-run.mov
14-a-support-project-name.mov
14-b-support-project-name.mov
14-c-support-project-name.mov
15-outro.mov
```

#### Chapters Folder

In the chapters folder, such as `a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff/chapters`, recordings are grouped and combined to form complete chapters of the project:

- **Compiled Chapters**: Each file represents a combined version of the recordings from the 'recordings' folder, named by their sequence and section, like '01-introduction.mov', '02-overview.mov'.
- **Cohesive Segments**: These files reflect the culmination of individual recordings and subparts, merged to create cohesive segments of the project or episode.

Here is an example from episode 1 of the FliVideo project Podcast.

```bash
# a27-ac-categorize-mp4-CI/01-flivideo-project-kickoff/chapters

01-introduction.mov
02-overview.mov
03-role_CI.mov
04-gpt-first-attempt.mov
05-first-commands.mov
06-commands.mov
07-commands-goal.mov
08-response_CI.mov
09-gpt-2nd-attempt.mov
10-gpt-goal.mov
11-gpt-goal-more.mov
12-code-cli.mov
13-code-cli-run.mov
14-support-project-name.mov
15-outro.mov
```

#### Sample Project #1 - Single Video

Example folder structure for single video projects

```bash
project-name/recordings/01-introduction.mov
project-name/recordings/02-a-content.mov
project-name/recordings/02-b-content.mov
project-name/recordings/03-a-outro.mov
project-name/recordings/03-b-outro-cta.mov
project-name/chapters/01-introduction.mov
project-name/chapters/02-content.mov
project-name/chapters/03-outro.mov
```

#### Sample Project #2 - Multiple Episodes

Example folder structure for multiple episode projects

```bash
project-name/01-episode-name/recordings/01-introduction.mov
project-name/01-episode-name/recordings/02-a-content.mov
project-name/01-episode-name/recordings/02-b-content.mov
project-name/01-episode-name/recordings/03-a-outro.mov
project-name/01-episode-name/recordings/03-b-outro-cta.mov
project-name/01-episode-name/chapters/01-introduction.mov
project-name/01-episode-name/chapters/02-content.mov
project-name/01-episode-name/chapters/03-outro.mov
```

```bash
project-name/02-different-episode-name/recordings/01-introduction.mov
project-name/02-different-episode-name/recordings/02-content.mov
project-name/02-different-episode-name/recordings/03-a-outro.mov
project-name/02-different-episode-name/recordings/03-b-outro-endcards.mov
project-name/02-different-episode-name/chapters/01-introduction.mov
project-name/02-different-episode-name/chapters/02-content.mov
project-name/02-different-episode-name/chapters/03-outro.mov
```

#### Sample Project #3 - Awaiting descision to keep or trash

Example folder structure where there are a bunch of files that I have not yet marked as Good Takes, 
All recordings need to be considered bad takes until I say save, at which time any prior bad takes will be moved to trash

1 project=1 standard video before trash

```bash
project-name/.trash  
project-name/recordings/01-introduction.mov
project-name/recordings/02-a-content.mov
project-name/recordings/02-b-content.mov
project-name/recordings/03-a-outro.mov
project-name/recordings/03-b-outro-cta.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 09.58.55.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 09.59.38.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.00.03.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.00.26.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.00.55.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.01.30.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.02.25.mov
project-name/recordings/Ecamm Live Recording on 2023-12-18 at 10.02.56.mov
```

#### Sample Project #4 - After trash

Notice that most of the bad takes have been moved to the trash folder, but the last one was named as 03-c-outro.mov 

1 project=1 standard video after trash

```bash
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 09.58.55.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 09.59.38.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 10.00.03.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 10.00.26.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 10.00.55.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 10.01.30.mov
project-name/.trash/Ecamm Live Recording on 2023-12-18 at 10.02.25.mov
project-name/recordings/01-introduction.mov
project-name/recordings/02-a-content.mov
project-name/recordings/02-b-content.mov
project-name/recordings/03-a-outro.mov
project-name/recordings/03-b-outro-cta.mov
project-name/recordings/03-c-outro.mov
```

