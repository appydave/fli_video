# FliVideo

ADD Affiliate Management to FliVideo

## Application Overview

FliVideo is a Video Asset Managment and publishing tool created by a YouTuber `@AppyDave` for YouTubers.

FliVideo is an internal proof of concept tool that is being developed to help manage the video creation process for Content Creators, @appydave is using a build in public approach to develop this tool and is sharing the development process on his YouTube channel.

It offers comprehensive organization and workflow management tools designed to automate and systematize the video production process.

Initially conceived as a "Zapier for YouTubers," FliVideo is evolving into a wholistic platform with a wide range of capabilities, including:

- Comprehensive Video Asset Management (VAM) for video, image, audio, and text content
- Streamlined video recording and project management tools
- Brand and YouTube channel management features
- Published content capture for future content repurposing, backlinking, and cross-promotion.
- Advanced AI-driven workflows for content creation and analysis

---

## End-to-End Content Ecosystem Management

FliVideo simplifies the entire content creation process with interconnected systems designed to streamline video recording, optimize workflows and maximize content utilization:

### FliVideo Core

The strategic and operational foundation of the platform, managing key elements like content creators, brands, channels, content pillars, and project configurations. 

It defines the ecosystem's structure while ensuring seamless integration and alignment across the Creative Hub, Launch Optimizer and Content Intelligence modules.

### Creative Hub
- Manages the recording, editing, and production process to streamline video creation and maintain organization.
- Supports tasks such as creating intros/outros, script quality analysis, suggeting CTA's, and maintaining consistency and tone across projects.

### Launch Optimizer

- Preparing and optimize YouTube videos with titles, thumbnails, descriptions other metadata.
- Amplify workflows for derivative content, such as articles, posts and tweets based on video content.

### Content Intelligence  
- Functions as a centralized repository for published content, enabling seamless discovery of related videos, metadata, and assets.
- Powers AI-driven features like cross-referencing content across channels, finding relevant videos for end cards, generating descriptions, and leveraging vector-based searches to enhance workflows.

## FliVideo Core - Key Concepts

### Content Creator:

Person or business who creates content for a specific audience. 
Creates content such as videos, lessons, podcasts, shorts, articles and tweets.
Focuses on specific niche, topic or framework.
 - A framework is a cross section of ideas that could include niche & topic, but aslo incorporate, style, format, philosophy, ethos or paradigm.

A contact creators will have one or more brands, content channels and content pillars that they create content for.

### Brand

A brand represents the overarching identity or persona that drives content creation, combining purpose, perception, and presentation.

Example: AppyDave (main brand) and AI-TLDR (secondary brand).

### Channel

Channels represent a platform or type of medioum to distribute content to the audience.

Example: YouTube (@AppyDave), Website (AppyDave.com), X (x.com/appydave), podcast platforms, Instagram, and other social media.

### Piller

Content pillars are thematic or conceptual categories that define the recurring focus areas within a brand’s content.

They serve as the foundation for long-term ideas or structured frameworks, encompassing a combination of niche, topic, format, and style.

Examples:

  AppyDave core pilars include prompt engineering, AI agents, and coding with AI, the secondary pillars are 555 Manifesto & KlueLess.

## Creative Hub - Key Concepts

### Project

Projects containers for a standalone video, video series or written content pieces.

Primary focus for FliVideo is on YouTube video projects, but secondary projects for written content are support.

### Project Types

Project types can be defined for each brand or channel to provide structure and rules.

- Video projects include long form videos, video series/podcast episodes, short form video, and course creation.
- Text based projects include articles, lessons, factsheets, ebooks, lead magnets.

### Rule Matcher

Rule matchers are used to identify new recordings, assets, or other digital content based on predefined criteria.
Match rules rely on a combination of file name patterns, folder locations, and file extensions to identify new content.

### Naming & Organization

FliVideo employs a structured naming convention and organization system to effectively manage video projects, episodes, recordings, images, and other digital assets.

Naming rules exist for projects, episodes, transcripts, recordings, b-roll and other digital assets.
Organization systems exist for brand, channel, project, episode, recording, chapter, and asset folders.
Distributed location organization exists for active, archived, or content shared between team members or platforms.

### Recording Session  

Recordings for video projects are structured as a sequence of parts and chapters to support better organization and workflow management.  
Sessions can be stored at either the project or episode level, allowing flexibility in managing different types of content.
As recordings are happening, they are processed on the fly, including real-time transcription. When a new chapter starts, a combined view of the transcription is generated, triggering chapter-specific events for advanced processing and organization.

### Asset Watchers

Asset Watchers actively monitor and automate the organization of digital assets in real time.

Examples:
  - Screen recording by Ecamm Live/OBS is renamed and moved to the appropriate project folder.
  - Medial downloads from Leonardo.ai or Canva are named and moved to the appropriate asset folder.

### Transcription

Video assets are automatically transcribed to text and stored in project asset folder at the time of recording.

### Text to AI

Certain text is sent to AI agents for further processing and analysis based on predefined criteria.

AI Agent Workflows:

AI workflows are categorized into two primary areas: generation and analysis.

- Generation: B-roll, chapter headings, script improvements, tweet generation and video to article.
- Analysis: Identify boring content, conduct fact-checking, perform keyword and sentiment analysis or detecting filler words

## Launch Optimizer - Key Concepts

### Editor Brief

The Editor Brief provides instructions and guidelines for the video editor, including key points, chapter titles, and suggested B-roll.

### Title

The title of the video is the most important part of the metadata.

### Thumbnail

The thumbnail is the first thing that people see when they are looking at your video.

Artwork, design guidelines, thumbnail text, and A/B testing are all important aspects of creating a thumbnail.

### Content Analysis

- Main topic or theme
- Extract relevant keywords.
- Important statistics or numbers mentioned.
- Highlight key takeaways or insights.
- Emotional Triggers and Tone:
- Overall Tone/Style:
- Audience Insights:
- Unique Selling Points (USPs):
- Identify call-to-action (CTA) phrases:
- Extract catchy phrases:
- Extract relevant questions:
- Extract search terms:

### Meta Data

- Keywords/tags
- Brand information or mentions
- Related videos/articles
- Primary and secondary CTA's.
- End cards

### Chapters

Chapter titles with timestamps

### Description

Build a description that includes video summary, chapters & meta data

### Amplify

- Pinned comment
- Tweet
- Articles (Medium, Dev.to, LinkedIn, Personal Blog)

### Shorts Analysis

- Identify potential shorts

## Content Intelligence - Key Concepts

### Content Repository

A centralized repository for all published content, including videos, articles, and social media posts across a content creators brands and channels.

### Content Graph

The content graph represents the interconnected relationships between videos, video series, shorts, articles, and social media posts across a content creator's brands and channels.

### Close out

Archive: Designed for long-term storage and backup of published content, preserving finalized assets and metadata.
Backup: Provides storage for unpublished or paused projects, retaining drafts, recordings, and materials for future use or potential repurposing.

## Workflows - Creative Hub

The following workflows are supported by the Creative Hub Module

**Focus Project**:

Switch between different video projects or episodes to accommodate changing content priorities.
Incoming recordings, transcripts and visual assets are routed to the project with current focus.
Project focus can be for standalone video or podcast episode/video series.

**New Recording**:

Video recordings via eCamm Live, OBS, Camtasia automatically route to the focus project based on rule match criteria.
Once routed, a new_recording event will trigger

**Recording Namer**:

The new_recording triggers automatic file renaming based on project, episode, chapter, part, and tags.
This workflow caters edgecases susch as for bad takes, rollbacks and renames.

**Transcribe**:

The new_recording will trigger real-time transcription of the video recording.

**New Chapter**:

An event fires on new chapter detection. 
Actions can include: Combine recordings, Build chapter transcript, Create chapter heading, create transition b-roll, chapter analysis

**Set Asset Type**:

Incoming assets are routed or tagged based on focus asset type.

**New Asset**:

Images downloaded from Canva, Leonardo.ai, or other sources can be named and moved automatically to the appropriate project asset folder.


## Lists

Lists 
























- 

### Core Functionality

- **Video Recording Management**: The application intelligently handles new video recordings and routes them to a target project location. Once a new recording is detected via configurable rules engine, it relocates the file to a specific project or episode folder.
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

## Glossary / Definitions

### Digital Asset Management vs Video Asset Management (DAM vs VAM)

Digital Asset Management (DAM) is a system that stores, organizes, and retrieves digital assets such as images, videos, and other multimedia files.

Video Asset Management (VAM) is a system that stores, organizes, and retrieves video assets such as video files, video clips, and other video-related files.

FliVideo leans more towards Video Asset Management (VAM) but also supports Digital Asset Management (DAM) for images, audio and other multimedia files.
