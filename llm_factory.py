"""
LLM Factory Module

This module provides a factory function to create LLM instances
for Google Gemini.

Usage:
    from llm_factory import get_llm
    
    # Use environment variable LLM_PROVIDER to select provider
    # Options: "gemini"
    llm = get_llm(model="gemini-pro", temperature=0, provider="gemini")
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
    Factory function to create LLM instances for Gemini.
    
    Args:
        model: Model name (provider-specific)
        temperature: Temperature for the model
        provider: LLM provider ("gemini")
                  If None, defaults to "gemini"
    
    Returns:
        BaseChatModel instance configured for the selected provider
    """
    # Get provider from parameter or environment variable
    if provider is None:
        provider = os.getenv("LLM_PROVIDER", "gemini")
    
    provider = provider.lower()
    
    if provider == "gemini":
        return _get_gemini_llm(model, temperature)
    raise ValueError(
        f"Unknown provider: {provider}. "
        "Supported providers: 'gemini'"
    )


def _get_gemini_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create Google Gemini LLM instance."""
    try:
        from llm_factory import get_llm
        
        if model is None:
            model = os.getenv("GEMINI_MODEL", "gemini-pro")
        
        return get_llm(
            model=model,
            temperature=temperature,
            google_api_key=os.getenv("GOOGLE_API_KEY")
        )
    except ImportError:
        raise ImportError(
            "Gemini integration requires langchain-google-genai. "
            "Install with: pip install langchain-google-genai"
        )

