FROM ghcr.io/lambda-feedback/evaluation-function-base/wolfram:latest

# Command to start the evaluation function with
ENV FUNCTION_COMMAND="wolframscript"

# Args to start the evaluation function with
ENV FUNCTION_ARGS="-f,/app/evaluation_function.wl"

# Interface to use for the evaluation function
ENV FUNCTION_INTERFACE="file"

ENV LOG_LEVEL="DEBUG"

# Copy Wolfram licence if present - stored as LICENCE.txt for working with the lambda_build Github Actions workflow
RUN if [ -f dist/LICENSE.txt ]; then cp dist/LICENSE.txt /home/wolframengine/.WolframEngine/Licensing/mathpass; else echo "No license file found."; fi

# Copy the evaluation function to the app directory
COPY ./evaluation_function.wl /app/evaluation_function.wl