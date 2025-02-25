# Chimera

> A powerful CI tool for Xcode and Swift packages that runs locally in your terminal.

<img src="https://github.com/user-attachments/assets/ffdbdd9f-896b-4662-8e43-5a0582d4dba7" width="512">

## Description:

This is a simple CI system using bash scripts to automate building, testing, and cleaning your Xcode projects and Swift packages locally in your terminal. It can also be used to build and test projects in the cloud. With github actions, you can run these scripts on a remote server.


## Problem

1.  **Slow Manual Processes:** Manually building, testing, and cleaning Xcode projects and Swift packages is time-consuming.
2.  **Error-Prone Manual Tasks:**  Manual processes are susceptible to human errors during building, testing, and cleaning.
3.  **Build Artifact Clutter:** Temporary build files (`Package.resolved`, `.build`) accumulate, wasting disk space and potentially causing build issues.

## Solution

1.  **Automated CI with Bash Scripts:**  Bash scripts are used to automate the build, test, and clean processes for Xcode projects and Swift packages.
2.  **Specific Task Scripts:**  Individual scripts are provided for testing Xcode schemes, testing Swift packages, and cleaning build artifacts, allowing for targeted automation.
3.  **Cleanup Scripts for Fresh Builds:** Scripts are included to remove `Package.resolved` and `.build` folders, ensuring clean builds, dependency updates, and disk space savings.

## File Structure:
Place the scripts like this in your xcode project folder:

```
.
├── run_ci.sh
├── build_schemes.sh
└── Packages/
    ├── run_all_scripts.sh
    ├── run_swift_builds.sh
    ├── run_swift_tests.sh
    ├── remove_package_resolved.sh
    └── remove_build_folders.sh
```


## Scripts

Here's a quick overview of each script:

*   **`run_ci.sh`**: Runs all CI scripts, including building Xcode schemes and running package scripts.
*   **`build_schemes.sh`**:  Builds and tests all Xcode schemes in your project.
*   **`Packages/run_all_scripts.sh`**: Runs all Swift package related scripts (build, test, clean).
*   **`Packages/run_swift_builds.sh`**: Builds all Swift packages.
*   **`Packages/run_swift_tests.sh`**: Runs tests for all Swift packages.
*   **`Packages/remove_package_resolved.sh`**: Deletes all `Package.resolved` files.
*   **`Packages/remove_build_folders.sh`**: Deletes all `.build` folders.

## How to Use

1.  **Go to your project's root in the terminal.**
2.  **Run the CI script:**

    ```bash
    ./run_ci.sh 
    ```

    Or, run scripts individually:

    ```bash
    ./build_schemes.sh
    ./Packages/run_all_scripts.sh
    ```

3.  **Check the output in your terminal.**

## Cleanup Scripts Explained

*   **`remove_package_resolved.sh`**:  Forces Swift Package Manager to re-download dependencies, ensuring you have the latest versions.
*   **`remove_build_folders.sh`**:  Frees up disk space and helps prevent build issues.

This system provides a basic, but useful, way to automate your local builds and tests. You can customize these scripts to fit your specific project needs.


## Github Actions

You can easily integrate these scripts into your GitHub Actions workflow to automate CI in the cloud. Here’s how you can set up a basic workflow to run your CI scripts:

1.  **Create a workflow file:** In your repository, create a file in `.github/workflows` directory, for example, `ci.yml`.
2.  **Set up the workflow:**  Here’s an example workflow that checks out your code and runs the `run_ci.sh` script:

    ```yaml
    name: Chimera CI

    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]

    jobs:
      build:
        runs-on: ubuntu-latest

        steps:
        - name: Checkout code
          uses: actions/checkout@v3

        - name: Make scripts executable
          run: chmod +x *.sh Packages/*.sh

        - name: Run Chimera CI
          run: ./run_ci.sh
    ```

    This workflow does the following:
    *   **`name: Chimera CI`**:  Sets the name of your workflow.
    *   **`on:`**:  Configures when the workflow will run. In this case, it runs on pushes to the `main` branch and pull requests targeting the `main` branch.
    *   **`jobs:`**:  Defines the jobs to be executed in the workflow.
        *   **`build:`**:  Defines a job named `build`.
            *   **`runs-on: ubuntu-latest`**: Specifies that this job will run on the latest version of Ubuntu.
            *   **`steps:`**:  A list of steps to execute in the job.
                *   **`actions/checkout@v3`**:  This action checks out your repository to the workflow workspace.
                *   **`chmod +x *.sh Packages/*.sh`**:  Makes all shell scripts executable.
                *   **`./run_ci.sh`**:  Runs the main CI script.


## Todo: 

- Try to run this on github actions
- Create a github action that builds and tests an array of remote projects
