![LangChain Academy](https://cdn.prod.website-files.com/65b8cd72835ceeacd4449a53/66e9eba1020525eea7873f96_LCA-big-green%20(2).svg)

## Introduction

Welcome to LangChain Academy, Introduction to LangGraph! 
This is a growing set of modules focused on foundational concepts within the LangChain ecosystem. 
Module 0 is basic setup and Modules 1 - 5 focus on building in LangGraph, progressively adding more advanced themes.  Module 6 addresses deploying your agents. 
In each module folder, you'll see a set of notebooks. A link to the LangChain Academy lesson is at the top of each notebook to guide you through the topic. Each module also has a `studio` subdirectory, with a set of relevant graphs that we will explore using the LangGraph API and Studio.

## Multi-Provider LLM Support

This repository has been refactored to support Google Gemini.

The code uses a factory pattern (`llm_factory.py`) that allows you to switch between providers using environment variables or by specifying the provider directly.

**Note:** This branch defaults to Gemini. You can still set `LLM_PROVIDER="gemini"` explicitly if you want.

## Setup

### Python version

Make sure you're using Python version 3.11, 3.12, or 3.13.
```
python3 --version
```

### Clone repo
```
git clone https://github.com/JotaTerrasa/langchain-academy-multi-provider.git
$ cd langchain-academy-multi-provider
```

### Create an environment and install dependencies
#### Mac/Linux/WSL
```
$ python3 -m venv lc-academy-env
$ source lc-academy-env/bin/activate
$ pip install -r requirements.txt
```
#### Windows Powershell
```
PS> python3 -m venv lc-academy-env
PS> Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
PS> .\lc-academy-env\Scripts\Activate.ps1
PS> pip install -r requirements.txt
```

### Running notebooks
If you don't have Jupyter set up, follow the installation instructions [here](https://jupyter.org/install).
```
$ jupyter notebook
```

### Setting up env variables
Briefly going over how to set up environment variables. 
#### Mac/Linux/WSL
```
$ export API_ENV_VAR="your-api-key-here"
```
#### Windows Powershell
```
PS> $env:API_ENV_VAR = "your-api-key-here"
```

## LLM Provider Configuration

### Using Google Gemini

Set the following environment variables:
```bash
export LLM_PROVIDER="gemini"
export GOOGLE_API_KEY="your-google-api-key"
export GEMINI_MODEL="gemini-pro"  # Optional, defaults to gemini-pro
```

To get a Google API key:
1. Go to [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Create a new API key
3. Set it in your environment

### Switching Providers in Code

You can also specify the provider directly in your code:

```python
from llm_factory import get_llm

# Use Gemini
llm = get_llm(model="gemini-pro", temperature=0, provider="gemini")
```

## Repository Branches

This repository has three main branches:
- **main**: Multi-provider branch (gemini + Gemini)
- **gemini**: Branch configured for gemini provider
- **gemini**: Branch configured for Gemini provider

To switch to a specific provider branch:
```bash
git checkout gemini  # or gemini
```

## Sign up and Set LangSmith API
* Sign up for LangSmith [here](https://docs.langchain.com/langsmith/create-account-api-key#create-an-account-and-api-key), find out more about LangSmith and how to use it within your workflow [here](https://www.langchain.com/langsmith). 
*  Set `LANGSMITH_API_KEY`, `LANGSMITH_TRACING_V2="true"` `LANGSMITH_PROJECT="langchain-academy"`in your environment 
*  If you are on the EU instance also set `LANGSMITH_ENDPOINT`="https://eu.api.smith.langchain.com" as well.

### Set up Tavily API for web search

* Tavily Search API is a search engine optimized for LLMs and RAG, aimed at efficient, 
quick, and persistent search results. 
* You can sign up for an API key [here](https://tavily.com/). 
It's easy to sign up and offers a very generous free tier. Some lessons (in Module 4) will use Tavily. 

* Set `TAVILY_API_KEY` in your environment.

### Set up Studio

* Studio is a custom IDE for viewing and testing agents.
* Studio can be run locally and opened in your browser on Mac, Windows, and Linux.
* See documentation [here](https://docs.langchain.com/langsmith/studio#local-development-server) on the local Studio development server. 
* Graphs for LangGraph Studio are in the `module-x/studio/` folders for module 1-5.
* To start the local development server, make sure your virtual environment is active and run the following command in your terminal in the `/studio` directory in each module:

```
langgraph dev
```

You should see the following output:
```
- 🚀 API: http://127.0.0.1:2024
- 🎨 Studio UI: https://smith.langchain.com/studio/?baseUrl=http://127.0.0.1:2024
- 📚 API Docs: http://127.0.0.1:2024/docs
```

Open your browser and navigate to the Studio UI: `https://smith.langchain.com/studio/?baseUrl=http://127.0.0.1:2024`.

* To use Studio, you will need to create a .env file with the relevant API keys
* Run this from the command line to create these files for module 1 to 5, as an example:
```
for i in {1..5}; do
  cp module-$i/studio/.env.example module-$i/studio/.env
  echo "LLM_PROVIDER=\"gemini\"" > module-$i/studio/.env
  echo "gemini_API_ENDPOINT=\"$gemini_API_ENDPOINT\"" >> module-$i/studio/.env
  echo "GOOGLE_API_KEY=\"$GOOGLE_API_KEY\"" >> module-$i/studio/.env
done
echo "TAVILY_API_KEY=\"$TAVILY_API_KEY\"" >> module-4/studio/.env
```

## Troubleshooting

### Provider-Specific Issues

**Gemini:**
- Make sure you've enabled the Generative AI API in Google Cloud Console
- Verify your API key is valid and has not expired
- Some models may require specific regions or quotas

## Contributing

This repository is based on the original [LangChain Academy](https://github.com/langchain-ai/langchain-academy) repository, with added multi-provider LLM support. Contributions are welcome!

