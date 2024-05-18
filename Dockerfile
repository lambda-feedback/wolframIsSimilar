# Final layer for public images, which does not contain the wolfram licence key,
# and is started with the shimmy serve command.
FROM ghcr.io/lambda-feedback/evaluation-function-base/wolfram:latest as base

# Command to start the evaluation function with
ENV FUNCTION_COMMAND="wolframscript"

# Args to start the evaluation function with
ENV FUNCTION_ARGS="-f,/app/evaluation_function.wl"

# Interface to use for the evaluation function
ENV FUNCTION_INTERFACE="file"

ENV LOG_LEVEL="DEBUG"

# Copy the evaluation function to the app directory
COPY ./evaluation_function.wl /app/evaluation_function.wl

# Final layer for lambda images, which contains the wolfram licence key,
# and is started with the shimmy lambda command.
FROM base as lambda

ENV HOME="/tmp/home"
ENV WOLFRAM_USERBASEDIRECTORY="/tmp/home"
ENV WOLFRAM_USERDOCUMENTSDIRECTORY="/tmp/home/Documents"
ENV WOLFRAM_DOCUMENTSDIRECTORY="/tmp/home/Documents"
ENV MATHEMATICA_USERBASE="/tmp/home/.WolframEngine"
ENV MATHEMATICAPLAYER_USERBASE="/tmp/home/.WolframEngine"

# Copy the mathpass secret to the Wolfram Engine licensing directory.
# See https://hub.docker.com/r/wolframresearch/wolframengine for more information.
RUN --mount=type=secret,id=mathpass \
    mkdir -p /tmp/home/.WolframEngine/Licensing && \
    cp /run/secrets/mathpass /tmp/home/.WolframEngine/Licensing/mathpass
