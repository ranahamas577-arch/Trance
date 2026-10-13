# Local Chatbot

A private desktop chatbot that runs on your computer. Your conversations, models, reminders, personalities, and plugins are stored on this device. The app does not send telemetry.

## Start the app

1. Open this folder in File Explorer.
2. Double-click **start.bat**.
3. The first launch prepares the app and opens a short setup guide. Keep the internet connected while it installs the app components and, if you choose, downloads the AI engine and model.
4. Your browser opens to `http://localhost:8765`.

On Windows, `start.bat` can install Python 3.12 automatically using Windows Package Manager when needed. The app's Python packages are installed in a private `.venv` folder, not system-wide. Keep the launcher window open while you use the app; closing the browser leaves Local Chatbot running in the system tray so reminders can still fire.

On macOS or Linux, run `./start.sh` from this folder. Python 3.11 or newer must already be installed.

The recommended first model is Qwen 2.5 7B Q4_K_M, about 5 GB. The engine and model downloads happen only during setup when you choose to download them. Once installed, local chat works offline. A smaller model may be more comfortable on computers with less memory.

## Using the app

- **Chat:** Stream local replies, stop generation, and keep a separate conversation for each personality.
- **Models:** Add a `.gguf` file from your computer or paste a direct Hugging Face file link. Downloaded files resume when possible. Choose load settings, load or unload a model, or delete it after confirmation.
- **Personalities:** Start with General Assistant, Coder, Researcher, or Companion. Copy a template to make your own, give it private memory, assign a model, and import or export it as JSON.
- **Reminders:** Type a date and time in everyday language or ask in Chat. Reminders can repeat and appear as desktop notifications. They continue while the app is running in the tray, even if the browser is closed.
- **Internet tools:** Search and page summaries are off unless you enable Internet access for that personality. The search makes an external request only after you use it; citations are shown with the reply.
- **VS Code:** Settings contains a Continue connection guide. The local OpenAI-compatible API is at `http://localhost:8765/v1`.
- **Plugins:** Describe a helper, review the generated code and explanation, then explicitly approve it before enabling. Tools run in a separate process with a restricted Python syntax and a short timeout.
- **Dependencies:** Check versions and computer hardware, repair app packages, or install the prebuilt model engine without compiling it.

## Privacy

The server listens on `127.0.0.1`, so it is available only on this computer. There is no account, login, or telemetry. Model downloads contact Hugging Face; engine downloads contact GitHub; package setup contacts the Python package index. Web search contacts DuckDuckGo only when you enable Internet access and ask a personality to search. Page summaries contact the public page you request. Chat prompts and conversation history stay local.

App logs are stored in `data/app.log`. Use **Settings > View app log** to inspect recent entries or **Export diagnostics** to download a ZIP. Nothing is sent automatically.

## Troubleshooting

**The browser says it cannot reach the page.** Leave the black launcher window open while using the app. If it closed, double-click `start.bat` again.

**The app says port 8765 is already being used.** Close another copy of Local Chatbot or the app using that port, then double-click `start.bat` again.

**Setup could not finish.** Check your internet connection and double-click `start.bat` again. It safely retries package setup. For a model or engine download, use the progress message in Models or Dependencies.

**Python could not be installed automatically.** Install Python 3.11 or newer, then try again. This can happen on older Windows versions without Windows Package Manager.

**The AI engine cannot be found.** Open Dependencies and choose Install/Repair next to `llama.cpp server`. A ready-made build is downloaded; nothing is compiled.

**A model will not load.** Try unloading it, reducing context length, or choosing a smaller GGUF file. CPU mode is available when a supported GPU is not detected.

**The GPU is not detected.** CPU mode is available. Integrated graphics may share system memory rather than have dedicated VRAM.

**A reminder did not appear.** Desktop notifications depend on your operating system's notification settings. The app must remain running in the tray. Missed reminders are saved and shown the next time you open the app.

**A plugin does not run.** Review the plugin's code and permissions, make sure it is approved and enabled for the selected personality, then try again. Plugins currently run without direct file or network access, even if those permissions are listed in a draft.

## Screenshots

[Screenshot placeholder: Dependencies and hardware page]

[Screenshot placeholder: Models and local chat]

[Screenshot placeholder: Personalities, reminders, and plugins]
