"""
LLM Factory Module

This module provides a factory function to create LLM instances
for Cerebras.

Usage:
    from llm_factory import get_llm
    
    # Use environment variable LLM_PROVIDER to select provider
    # Options: "cerebras"
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
    Factory function to create LLM instances for Cerebras.
    
    Args:
        model: Model name (provider-specific)
        temperature: Temperature for the model
        provider: LLM provider ("cerebras")
                  If None, defaults to "cerebras"
    
    Returns:
        BaseChatModel instance configured for the selected provider
    """
    # Get provider from parameter or environment variable
    if provider is None:
        provider = os.getenv("LLM_PROVIDER", "cerebras")
    
    provider = provider.lower()
    
    if provider == "cerebras":
        return _get_cerebras_llm(model, temperature)
    raise ValueError(
        f"Unknown provider: {provider}. "
        "Supported providers: 'cerebras'"
    )


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


