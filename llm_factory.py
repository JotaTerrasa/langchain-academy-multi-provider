"""
LLM Factory Module

This module provides a factory function to create LLM instances
for different providers: OpenAI, Cerebras, and Gemini.

Usage:
    from llm_factory import get_llm
    
    # Use environment variable LLM_PROVIDER to select provider
    # Options: "openai", "cerebras", "gemini"
    llm = get_llm(model="gpt-4o", temperature=0)
"""

import os
from typing import Optional
from langchain_core.language_models.chat_models import BaseChatModel


def get_llm(
    model: Optional[str] = None,
    temperature: float = 0,
    provider: Optional[str] = None
) -> BaseChatModel:
    """
    Factory function to create LLM instances for different providers.
    
    Args:
        model: Model name (provider-specific)
        temperature: Temperature for the model
        provider: LLM provider ("openai", "cerebras", "gemini")
                  If None, uses LLM_PROVIDER environment variable
    
    Returns:
        BaseChatModel instance configured for the selected provider
    """
    # Get provider from parameter or environment variable
    if provider is None:
        provider = os.getenv("LLM_PROVIDER", "openai").lower()
    
    provider = provider.lower()
    
    if provider == "openai":
        return _get_openai_llm(model, temperature)
    elif provider == "cerebras":
        return _get_cerebras_llm(model, temperature)
    elif provider == "gemini":
        return _get_gemini_llm(model, temperature)
    else:
        raise ValueError(
            f"Unknown provider: {provider}. "
            "Supported providers: 'openai', 'cerebras', 'gemini'"
        )


def _get_openai_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create OpenAI LLM instance."""
    from langchain_openai import ChatOpenAI
    
    if model is None:
        model = os.getenv("OPENAI_MODEL", "gpt-4o")
    
    return ChatOpenAI(model=model, temperature=temperature)


def _get_cerebras_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create Cerebras LLM instance using OpenAI-compatible API."""
    from langchain_openai import ChatOpenAI
    
    # Cerebras typically provides an OpenAI-compatible API endpoint
    cerebras_endpoint = os.getenv("CEREBRAS_API_ENDPOINT")
    if not cerebras_endpoint:
        raise ValueError(
            "CEREBRAS_API_ENDPOINT environment variable is required for Cerebras. "
            "Set it to your Cerebras API endpoint URL."
        )
    
    if model is None:
        model = os.getenv("CEREBRAS_MODEL", "llama-70b")
    
    cerebras_api_key = os.getenv("CEREBRAS_API_KEY")
    if not cerebras_api_key:
        raise ValueError(
            "CEREBRAS_API_KEY environment variable is required for Cerebras"
        )
    
    # Use ChatOpenAI with custom endpoint for Cerebras compatibility
    return ChatOpenAI(
        model=model,
        temperature=temperature,
        openai_api_base=cerebras_endpoint,
        openai_api_key=cerebras_api_key
    )


def _get_gemini_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create Google Gemini LLM instance."""
    try:
        from langchain_google_genai import ChatGoogleGenerativeAI
        
        if model is None:
            model = os.getenv("GEMINI_MODEL", "gemini-pro")
        
        return ChatGoogleGenerativeAI(
            model=model,
            temperature=temperature,
            google_api_key=os.getenv("GOOGLE_API_KEY")
        )
    except ImportError:
        raise ImportError(
            "Gemini integration requires langchain-google-genai. "
            "Install with: pip install langchain-google-genai"
        )
