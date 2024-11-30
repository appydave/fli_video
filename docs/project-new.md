# Requirements Document for Project Management Tool

## 1. Overview
This document outlines the requirements for a command-line tool and supporting backend system for creating, renaming, and managing projects across multiple business units. The tool uses sequential naming conventions and integrates with a web server API for centralized management. This system is designed for a single-user environment.

## 2. Business Objectives
- Automate project creation, renaming, and listing for multiple business units.
- Maintain consistent naming conventions with sequential identifiers.
- Enforce folder structures based on project types.
- Separate business rules between local and server environments for scalability.

## 3. Functional Requirements

### 3.1 Command-Line Tool
The tool provides the following commands:

#### 3.1.1 Creating a New Project
**Command:**
```
ad-project-new <business_unit> <project_type> "<project_name>"
```
**Example:**
```
ad-project-new appydave video "hello-world"
```
**Expected Outcome:**
- Generates a new project folder.
- Assigns a sequential identifier, e.g., `a05-hello-world`.
- Logs the output:
  ```yaml
  Project created: a05-hello-world
  ```

#### 3.1.2 Renaming a Project
**Command:**
```
ad-project-rename <business_unit> <project_type> <project_id> "<new_project_name>"
```
**Example:**
```
ad-project-rename appydave video a05 "rails8"
```
**Expected Outcome:**
- Updates the project folder name to `a05-rails8`.
- Logs the change:
  ```yaml
  Project renamed: a05-rails8
  ```

#### 3.1.3 Listing Projects
**Command for all projects:**
```
ad-project-list <business_unit> <project_type>
```
**Command for last N projects:**
```
ad-project-list <business_unit> <project_type> -l <number>
```
**Examples:**

**All Projects:**
```
ad-project-list appydave video
```
**Output:**
```css
a01-intro-video
a02-tutorial
a03-promo-video
```

**Last 3 Projects:**
```
ad-project-list appydave video -l 3
```
**Output:**
```css
a03-promo-video
a02-tutorial
a01-intro-video
```

## 4. Non-Functional Requirements
- Must work as a single-user tool on the local environment.
- The command-line tool will interact with the backend via RESTful APIs to ensure database consistency.

## 5. Entities and Database Design

### 5.1 Entities
- **Business Unit**: Represents channels like "AppyDave" or "AITLDR".
- **Project Type**: Defines types like "Video" or "Article".
- **Project**: Tracks individual projects, including name and sequential identifier.
- **Folder Structure**: Stores default folders for each project type.

### 5.2 Entity Relationship Diagram (ERD)
**ERD Diagram Description:**
- **Business Unit** links to **Project** (one-to-many relationship).
- **Project Type** links to **Folder Structure** (one-to-one relationship).
- **Project** has attributes like ID, Name, and Type.

(An actual diagram would be helpful here; I can generate one if needed.)

## 6. System Architecture

### 6.1 Web Server
- Maintains the central database.
- Provides RESTful APIs:
  - `POST /projects`: Create a new project.
  - `PUT /projects/:id`: Rename a project.
  - `GET /projects`: List projects.

### 6.2 Command-Line Tool
- Acts as a local interface to execute commands.
- Interacts with the web server for updates and fetching data.

## 7. Example API Interactions

### 7.1 Create a New Project
**Request:**
```
POST /projects
Content-Type: application/json

{
  "business_unit": "appydave",
  "project_type": "video",
  "project_name": "hello-world"
}
```
**Response:**
```json
{
  "status": "success",
  "project_id": "a05",
  "project_name": "a05-hello-world"
}
```

### 7.2 Rename a Project
**Request:**
```
PUT /projects/a05
Content-Type: application/json

{
  "new_name": "rails8"
}
```
**Response:**
```json
{
  "status": "success",
  "project_name": "a05-rails8"
}
```

### 7.3 List Projects
**Request:**
```
GET /projects?business_unit=appydave&project_type=video&limit=3
```
**Response:**
```json
[
  {
    "id": "a03",
    "name": "promo-video"
  },
  {
    "id": "a02",
    "name": "tutorial"
  },
  {
    "id": "a01",
    "name": "intro-video"
  }
]
```

## 8. Corrections and Finalized Decisions
- Sequential identifiers are three letters followed by a number (e.g., `a05`), followed by the project name.
- Output logs should always include the project identifier for user reference.
- Simplified to focus on a single-user environment.

