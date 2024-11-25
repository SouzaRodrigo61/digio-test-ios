# Digio - iOS Application

## Overview

---

## Installation

### Prerequisites

- **macOS** with the latest version of **Xcode** installed.
- **Tuist** installed. If not installed, you can install it using the following command:

   ```bash
   brew tap tuist/tuist
   brew install tuist
   ```

### Setup

1. **Get Packages:**

   ```bash
   tuist install
   ```

2. **Generate the Xcode Project:**

   Use Tuist to generate the Xcode project files:

   ```bash
   tuist generate
   ```

   This will automatically resolve dependencies via Swift Package Manager (SPM) and set up the project.

3. **Open the Project:**

   After generating the project, open it in Xcode:

   ```bash
   open Digio.xcodeproj
   ```

4. **Build and Run:**

   Select your target device or simulator in Xcode and press `Cmd + R` to build and run the project.

## Project Template with Tuist

This guide explains how to use templates in Tuist to organize your project by clearly separating components and modules. Follow the instructions below to set up and generate your Xcode project.

1. **Shared Components:**

- Shared components are those used across various parts of the project, such as Authentication, HealthKit, StoreKit, and similar services. To create a new shared component, run the following command, replacing `<Shared>` with the name of the component you want to create:

   ```bash
   tuist scaffold Shared --name <Shared>
   ```

   Example:

   ```bash
   tuist scaffold Shared --name Authentication
   ```

- This command will generate the basic structure needed for the shared component.

2. **Modules:**

- Modules represent specific features of your application, such as Settings, Home, and others. To create a new module, use the following command, replacing `<Module>` with the name of the desired module:

   ```bash
   tuist scaffold Module --name <Module>
   ```

   Example:

   ```bash
   tuist scaffold Module --name Home
   ```

- This command will create the basic structure for the specific feature module.

3. **Generate the Xcode Project:**

- After creating the necessary components and modules, use Tuist to generate the Xcode project files:

   ```bash
   tuist generate
   ```

   This command will:

   - Automatically resolve dependencies via Swift Package Manager (SPM).
   - Configure and generate the Xcode project with the defined structure.

- Your project will now be ready to open and edit in Xcode, with all necessary dependencies and configurations set up.

## Usage

- Upon launching the app, users will be prompted to set their notification preferences, such as the type of reminders and the frequency.
- The app will then run in the background, sending notifications with sound alerts to remind users to take action based on their preferences.
- The user can revisit the settings at any time to adjust the notification preferences.

## Contributing

We welcome contributions to improve Digio. Please fork the repository and submit a pull request for any changes you would like to propose.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact

If you have any questions or need further assistance, please feel free to open an issue or contact us directly.