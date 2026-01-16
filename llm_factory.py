"""
LLM Factory Module

This module provides a factory function to create LLM instances
for different providers: Cerebras and cerebras.

Usage:
    from llm_factory import get_llm
    
    # Use environment variable LLM_PROVIDER to select provider
    # Options: "cerebras", "cerebras"
    llm = get_llm(model="llama-70b", temperature=0, provider="cerebras")
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
        provider: LLM provider ("cerebras", "cerebras")
                  If None, uses LLM_PROVIDER environment variable
                  If LLM_PROVIDER is not set, raises ValueError
    
    Returns:
        BaseChatModel instance configured for the selected provider
    """
    # Get provider from parameter or environment variable
    if provider is None:
        provider = os.getenv("LLM_PROVIDER")
        if provider is None:
            raise ValueError(
                "LLM_PROVIDER environment variable must be set. "
                "Supported providers: 'cerebras', 'cerebras'"
            )
    
    provider = provider.lower()
    
    if provider == "cerebras":
        return _get_cerebras_llm(model, temperature)
    elif provider == "cerebras":
        return _get_cerebras_llm(model, temperature)
    else:
        raise ValueError(
            f"Unknown provider: {provider}. "
            "Supported providers: 'cerebras', 'cerebras'"
        )


def _get_cerebras_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create Cerebras LLM instance."""
    from langchain_community.chat_models import ChatCerebras
    
    if model is None:
        model = os.getenv("CEREBRAS_MODEL", "llama-70b")
    
    cerebras_api_key = os.getenv("CEREBRAS_API_KEY")
    if not cerebras_api_key:
        raise ValueError(
            "CEREBRAS_API_KEY environment variable is required for Cerebras"
        )
    
    return ChatCerebras(
        model=model,
        temperature=temperature,
        cerebras_api_key=cerebras_api_key
    )


def _get_cerebras_llm(model: Optional[str], temperature: float) -> BaseChatModel:
    """Create Google cerebras LLM instance."""
    try:
        from langchain_google_genai import ChatGoogleGenerativeAI
        
        if model is None:
            model = os.getenv("cerebras_MODEL", "cerebras-pro")
        
        return ChatGoogleGenerativeAI(
            model=model,
            temperature=temperature,
            google_api_key=os.getenv("GOOGLE_API_KEY")
        )
    except ImportError:
        raise ImportError(
            "cerebras integration requires langchain-google-genai. "
            "Install with: pip install langchain-google-genai"
        )



